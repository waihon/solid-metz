require_relative 'patent'
require 'csv'
require 'active_support/inflector'

class PatentJob
  attr_reader :downloader

  def initialize(opts = {})
    config = opts[:config] ||= Config.new(env: 'production', filename: 'patent.yml')
    @downloader = opts[:downloader] ||= config.downloader_class.constantize.new(config)
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
