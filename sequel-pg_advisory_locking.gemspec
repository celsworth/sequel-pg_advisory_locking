# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
	spec.name          = "sequel-pg_advisory_locking"
	spec.version       = '1.0.1'
	spec.authors       = ["Chris Elsworth"]
	spec.email         = ["chris@cae.me.uk"]
	spec.summary       = "Adds PostgreSQL advisory locking support to Sequel"
	spec.homepage      = "https://github.com/celsworth/sequel-pg_advisory_locking"
	spec.license       = "MIT"

	spec.files         = `git ls-files -z`.split("\x0")
	spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
	spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
	spec.require_paths = ["lib"]

	spec.add_runtime_dependency 'sequel'
end
