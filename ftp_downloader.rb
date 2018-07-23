require 'tempfile'
require 'net/ftp'
require_relative 'config'

class FtpDownloader
  attr_reader :config

  def initialize(config=Config.new(env: 'production', filename: 'patent.yml'))
    @config = config
  end

  def download_file
    temp = Tempfile.new(config.ftp_filename)
    tempname = temp.path
    temp.close
    Net::FTP.open(config.ftp_host, user = config.ftp_login, passwd = config.ftp_password) do |ftp|
      ftp.getbinaryfile(File.join(config.ftp_path, config.ftp_filename), tempname)
    end
    tempname
  end
end
