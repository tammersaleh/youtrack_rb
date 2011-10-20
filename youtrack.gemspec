# -*- encoding: utf-8 -*-
require File.expand_path("../lib/youtrack/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "youtrack"
  s.version     = YouTrack::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Tammer Saleh"]
  s.email       = ["tsaleh@gmail.com"]
  s.homepage    = "http://www.jetbrains.com/youtrack/"
  s.summary     = "YouTrack Ruby Client"
  s.description = "Use this to interact with YouTrack"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "ey_youtrack"

  # s.add_dependency "rest-client"
  # s.add_dependency "nokogiri"
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", "~> 2.0"
  s.add_development_dependency "ZenTest"
  s.add_development_dependency "autotest-fsevent"
  s.add_development_dependency "autotest-growl"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
