require 'tempfile'
require 'net/ftp'

class PatentDownloader
  def download_file
    temp = Tempfile.new('patents')
    tempname = temp.path
    temp.close
    Net::FTP.open('localhost', user = 'foo', passwd = 'foopw') do |ftp|
      ftp.getbinaryfile('/data/prod/patents.csv', tempname)
    end
    tempname
  end
end
