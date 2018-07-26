require_relative '../patent_job'

describe PatentJob do
  context "with defined config and downloader" do
    it "should replace existing patents with new patents" do
      downldr = mock('Downloader')
      f = './data/test/patents.csv'
      downldr.should_receive(:download_file).once.and_return(f)
      config = Config.new(env: 'test', filename: 'patent.yml')
      @job = PatentJob.new(config: config, downloader: downldr)
      @job.run
      Patent.all.should have(3).rows
      Patent.find_by_name('Dev Anti-Gravity Simulator').should be
      Patent.find_by_name('Dev Exo-Skello Jello').should be
      Patent.find_by_name('Dev Nap Compressor').should be
    end
  end

  context "with default config and downloader" do
    it "should replace existing patents with new patents" do
      @job = PatentJob.new
      @job.run
      Patent.all.should have(3).rows
      Patent.find_by_name('Anti-Gravity Simulator').should be
      Patent.find_by_name('Exo-Skello Jello').should be
      Patent.find_by_name('Nap Compressor').should be
    end
  end
end
