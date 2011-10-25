require "#{File.dirname(__FILE__)}/helper"

describe YouTrack do
  describe ".connection(:host => 'foo.com', :username => 'un', :password => 'pw')" do
    before  { @connection = YouTrack.connection(:host => 'foo.com', :username => 'un', :password => 'pw') }
    subject { @connection }

    it "returns a YouTrack::Connection object" do
      should be_a YouTrack::Connection
    end
  end
end
