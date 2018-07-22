require_relative 'patent'
require 'tempfile'
require 'net/ftp'
require 'csv'

class PatentJob
  def run
    temp = download_file
    rows = parse(temp)
    update_patents(rows)
  end

  def download_file
    temp = Tempfile.new('patents')
    tempname = temp.path
    temp.close
    Net::FTP.open('localhost', user = 'foo', passwd = 'foopw') do |ftp|
      ftp.getbinaryfile('/data/prod/patents.csv', tempname)
    end
    tempname
  end

  def parse(temp)
    CSV.read(temp, headers: true)
  end

  def update_patents(rows)
    Patent.connection.transaction do
      Patent.delete_all
      rows.each { |r| Patent.create!(r.to_hash) }
    end
  end
end
