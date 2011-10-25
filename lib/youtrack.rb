require "nokogiri"
require "rest-client"

module YouTrack
  def self.connection(*opts)
    YouTrack::Connection.new(*opts)
  end
end

require "#{File.dirname(__FILE__)}/youtrack/hash_xml_extension"
require "#{File.dirname(__FILE__)}/youtrack/exceptions"
require "#{File.dirname(__FILE__)}/youtrack/connection"
require "#{File.dirname(__FILE__)}/youtrack/issue"
