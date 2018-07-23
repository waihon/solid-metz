require_relative 'patent'
require 'csv'

class PatentJob
  attr_reader :downloader

  def initialize(downloader=FtpDownloader.new)
    @downloader = downloader
  end

  def run
    temp = downloader.download_file
    rows = parse(temp)
    update_patents(rows)
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
