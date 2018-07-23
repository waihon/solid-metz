require_relative '../ftp_downloader'

describe FtpDownloader do
  it "should download the CSV file from the FTP server" do
    @conn = FtpDownloader.new(Config.new(env: 'test', filename: 'patent.yml'))
    f = File.read(@conn.download_file)
    f.should have(251).characters
    f.include?("just 3 minutes").should be_true
  end
end
