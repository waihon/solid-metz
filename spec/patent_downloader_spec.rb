require_relative '../patent_downloader'

describe PatentDownloader do
  it "should download the CSV file from the FTP server" do
    # upload_test_file('localhost', 'ftpuser', 'ftpuserpw',
    #                  'patents.csv', '/data/test')

    @conn = PatentDownloader.new
    f = File.read(@conn.download_file)
    f.should have(251).characters
    f.include?("just 3 minutes").should be_true
  end
end
