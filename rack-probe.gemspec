# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack-probe}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["ecin"]
  s.date = %q{2009-08-21}
  s.description = %q{Rack::Probe provides a set of probes for Rack that fire with each request.}
  s.email = %q{ecin@copypastel.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "lib/rack-probe.rb",
     "lib/rack/probe.rb",
     "rack-probe.gemspec",
     "spec/rack/probe_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/ecin/rack-probe}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Rack::Probe adds Dtrace probes to your Rack apps.}
  s.test_files = [
    "spec/rack/probe_spec.rb",
     "spec/spec_helper.rb"
  ]

  s.add_dependency("ruby-usdt", "~> 0.0")
  s.add_dependency("rack", ">= 1.0.0")
end
