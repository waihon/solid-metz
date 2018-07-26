require_relative '../patent_job'

describe PatentJob do
  it "should replace existing patents with new patents" do
    downldr = mock('Downloader')
    f = './patents.csv'
    downldr.should_receive(:download_file).once.and_return(f)
    config = Config.new(env: 'test', filename: 'patent.yml')
    @job = PatentJob.new(config: config, downloader: downldr)
    @job.run
    Patent.all.should have(3).rows
    Patent.find_by_name('Anti-Gravity Simulator').should be
    Patent.find_by_name('Exo-Skello Jello').should be
    Patent.find_by_name('Nap Compressor').should be
  end
end
