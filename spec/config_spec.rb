require_relative '../config'

describe Config do
  it "should know the common configuration values" do
    @conf = Config.new(filename: 'patent.yml')
    @conf.ftp_host.should eql('localhost')
    @conf.ftp_filename.should eql('patents.csv')
    @conf.ftp_login.should eql('ftpuser')
    @conf.ftp_password.should eql('ftpuserpw')
  end
end

describe "should know the correct path for" do
  it "development" do
    @conf = Config.new(env: 'development', filename: 'patent.yml')
    @conf.ftp_path.should eql('/data/dev')
  end

  it "test" do
    @conf = Config.new(env: 'test', filename: 'patent.yml')
    @conf.ftp_path.should eql('/data/test')
  end

  it "production" do
    @conf = Config.new(env: 'production', filename: 'patent.yml')
    @conf.ftp_path.should eql('/data/prod')
  end
end

