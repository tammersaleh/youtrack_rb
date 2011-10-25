require "nokogiri"
require "rest-client"

module YouTrack
  def self.connection(*opts)
    YouTrack::Connection.new(*opts)
  end
end

Dir["#{File.dirname(__FILE__)}/youtrack/*.rb"].each do |path|
  require path
end
