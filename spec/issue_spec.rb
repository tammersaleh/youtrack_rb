require "#{File.dirname(__FILE__)}/helper"

describe YouTrack::Issue do
  describe ".new_from_xml" do
    before do
      xml_issue_body = <<-EOS.chomp
<issue priority="3" type="Feature" state="Fixed" subsystem="No subsystem" id="HBR-22" fixedVersion="2.0" projectShortName="HBR" assigneeName="beto" reporterName="beto" fixedInBuild="Next build" commentsCount="0" numberInProject="22" summary="Foo" description="Bar" created="1159376031000" updated="1162215322000" updatedByFullName="Beto Software" historyUpdated="1162215322000" resolved="1260367511434" reporterFullName="Beto Software" votes="0">
  <links></links>
  <attachments></attachments>
</issue>
EOS
      @issue = YouTrack::Issue.new_from_xml(xml_issue_body)
    end
    subject { @issue }

    its([:priority]) { should == 3 }
    its([:state])    { should == "Fixed" }
    its([:resolved]) { should == Time.new(2009, 12, 9, 6, 5, 11) }
    its([:id])       { should == "HBR-22" }
    its([:type])     { should == "Feature" }
  end

  # $ curl https://tsaleh:secret@tickets.engineyard.com/rest/issue/Road-1
  # <?xml version="1.0" encoding="UTF-8" standalone="yes"?><issue id="Road-1"><field name="voterName"/><comment id="43-11296" author="tcareysmith" issueId="Road-1" deleted="false" text="Aiming for a start of this next week. 2011/07/18" shownForIssueAuthor="false" created="1310601391815"><replies/></comment><comment id="43-11959" author="tsaleh" issueId="Road-1" deleted="false" text="We spent a week on this and made some really great progress.  I've associate all of the existing tickets to Tracker-11, and am closing this one." shownForIssueAuthor="false" created="1311703020303"><replies/></comment><field name="Priority"><value>Normal</value></field><field name="State"><value>Completed</value></field><field name="Effort"><value>XX</value></field><field name="Teams"><value>Platform team</value></field><field name="links"><value type="Depend" role="depends on">PL-4271</value><value type="Depend" role="depends on">PL-4198</value><value type="Depend" role="depends on">PL-4873</value><value type="Depend" role="depends on">PL-4861</value><value type="Depend" role="depends on">PL-5096</value><value type="Relates" role="relates to">PL-5002</value><value type="Depend" role="depends on">PL-2851</value><value type="Depend" role="is required for">Vertical-11</value><value type="Depend" role="depends on">PL-5215</value><value type="Depend" role="depends on">PL-4734</value><value type="Depend" role="depends on">PL-4904</value><value type="Relates" role="relates to">PL-5414</value></field><field name="projectShortName"><value>Road</value></field><field name="numberInProject"><value>1</value></field><field name="summary"><value>Make Account Cancellation Good</value></field><field name="description"><value>Real Good.
  # 
  # A placeholder ticket for a set of tickets all related to account cancellation.</value></field><field name="created"><value>1308031852704</value></field><field name="updated"><value>1311801192679</value></field><field name="updaterName"><value>tcareysmith</value></field><field name="resolved"><value>1311703035002</value></field><field name="reporterName"><value>awoodward</value></field><field name="commentsCount"><value>2</value></field><field name="votes"><value>0</value></field></issue>
end
