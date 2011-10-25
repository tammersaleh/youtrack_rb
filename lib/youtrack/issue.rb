class YouTrack::Issue
  def self.new_from_xml(xml)
    new(xml_to_hash(xml))
  end

  def self.xml_to_hash(xml_text)
    Hash.from_xml(xml_text)[:issue]
  end

  def initialize(values = {})
    @values = values
  end

  def [](key)
    translated_xml_value(@values[:attributes][key.to_sym])
  end

  def translated_xml_value(v)
    if v.to_s =~ /\d{13}/
      Time.at(v / 1000)
    else
      v
    end
  end
end
