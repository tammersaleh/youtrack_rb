class YouTrack::Connection
  attr_accessor :username, :password, :host, :url

  def initialize(opts = {})
    opts.each do |k,v|
      self.send("#{k}=", v)
    end
    # TODO: move to method
    self.url = "https://#{username}:#{password}@#{host}" if username and password and host
  end

  def issues
    get("/issues").css("issues issue").map do |node|
      YouTrack::Issue.new_from_xml node.to_html
    end
  end

  def get(path)
    Nokogiri.parse(RestClient.get(URI.encode("#{url}#{path}"), :content_type => "application/xml"))
  end
end
