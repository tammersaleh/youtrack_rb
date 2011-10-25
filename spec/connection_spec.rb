require "#{File.dirname(__FILE__)}/helper"

describe YouTrack::Connection do
  describe ".new without arguments" do
    before  { @connection = YouTrack::Connection.new }
    subject { @connection }

    its(:username) { should == nil }
    its(:password) { should == nil }
    its(:host)     { should == nil }
    its(:url)      { should == nil }
  end

  describe ".new with arguments" do
    before do 
      @connection = YouTrack::Connection.new(:username => "tsaleh", 
                                             :password => "secret", 
                                             :host     => "yt.com")
    end
    subject { @connection }

    its(:username) { should == "tsaleh" }
    its(:password) { should == "secret" }
    its(:host)     { should == "yt.com" }
    its(:url)      { should == "https://tsaleh:secret@yt.com" }
  end

  describe "#issues" do
    before do 
      xml_issue_body = <<-EOS.chomp
<issue priority="3" type="Feature" state="Fixed" subsystem="No subsystem" id="HBR-22" fixedVersion="2.0" projectShortName="HBR" assigneeName="beto" reporterName="beto" fixedInBuild="Next build" commentsCount="0" numberInProject="22" summary="Foo" description="Bar" created="1159376031000" updated="1162215322000" updatedByFullName="Beto Software" historyUpdated="1162215322000" resolved="1260367511434" reporterFullName="Beto Software" votes="0">
  <links></links>
  <attachments></attachments>
</issue>
EOS
      FakeWeb.register_uri(:get, 
                           "https://tsaleh:secret@yt.com/issues", 
                           :body => <<-EOS)
                             <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
                             <issues>#{xml_issue_body}</issues>
      EOS
      YouTrack::Issue.stub(:new_from_xml).with(xml_issue_body) { :issue_from_xml }
      @issues = YouTrack::Connection.new(:username => "tsaleh", :password => "secret", :host => "yt.com").issues
    end
    subject { @issues }

    it "returns issue instances from the XML returned from the server" do
      should == [:issue_from_xml]
    end
  end

#   describe "#issues()" do
#     before do 
#       xml_issue_body = <<-EOS.chomp
# <issue priority="3" type="Feature" state="Fixed" subsystem="No subsystem" id="HBR-22" fixedVersion="2.0" projectShortName="HBR" assigneeName="beto" reporterName="beto" fixedInBuild="Next build" commentsCount="0" numberInProject="22" summary="Foo" description="Bar" created="1159376031000" updated="1162215322000" updatedByFullName="Beto Software" historyUpdated="1162215322000" resolved="1260367511434" reporterFullName="Beto Software" votes="0">
#   <links></links>
#   <attachments></attachments>
# </issue>
# EOS
#       FakeWeb.register_uri(:get, 
#                            "https://tsaleh:secret@yt.com/issues", 
#                            :body => <<-EOS)
#                              <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
#                              <issues>#{xml_issue_body}</issues>
#       EOS
#       YouTrack::Issue.stub(:new_from_xml).with(xml_issue_body) { :issue_from_xml }
#       @issues = YouTrack::Connection.new(:username => "tsaleh", :password => "secret", :host => "yt.com").issues
#     end
#     subject { @issues }
# 
#     it "returns issue instances from the XML returned from the server" do
#       should == [:issue_from_xml]
#     end
#   end
end

