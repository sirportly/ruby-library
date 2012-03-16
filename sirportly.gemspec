Gem::Specification.new do |s|
  s.name = 'sirportly'
  s.version = "1.1.0"
  s.platform = Gem::Platform::RUBY
  s.summary = "Easy to use client library for Sirportly"
  s.files = Dir["lib/sirportly.rb", 'lib/sirportly/*.rb']
  s.bindir = "bin"
  s.require_path = 'lib'
  s.has_rdoc = false
  s.author = "Adam Cooke"
  s.email = "adam@atechmedia.com"
  s.homepage = "http://www.sirportly.com"
end
