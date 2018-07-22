require_relative 'patent_job'

describe PatentJob do
  it "should download the CSV file from the FTP server" do
    @job = PatentJob.new
    f = File.read(@job.download_file)
    f.should have(251).characters
    f.include?("just 3 minutes").should be_true
  end

  it "should replace existing patents with new patents" do
    @job = PatentJob.new
    @job.run
    Patent.all.should have(3).rows
    Patent.find_by_name('Anti-Gravity Simulator').should be
    Patent.find_by_name('Exo-Skello Jello').should be
    Patent.find_by_name('Nap Compressor').should be
  end
end
