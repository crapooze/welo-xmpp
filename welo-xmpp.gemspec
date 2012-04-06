# -*- encoding: utf-8 -*-
require File.expand_path('../lib/welo-xmpp/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["crapooze"]
  gem.email         = ["crapooze@gmail.com"]
  gem.description   = %q{A Gem to transfer Welo resources with Blather}
  gem.summary       = %q{Adds handler for Welo resources with Blather's XMPP-client library}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "welo-xmpp"
  gem.require_paths = ["lib"]
  gem.version       = Welo::Xmpp::VERSION
end
