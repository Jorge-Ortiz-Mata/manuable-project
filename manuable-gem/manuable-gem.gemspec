require_relative "lib/manuable/gem/version"

Gem::Specification.new do |spec|
  spec.name        = "manuable-gem"
  spec.version     = Manuable::Gem::VERSION
  spec.authors     = ["Jorge-Ortiz-Mata"]
  spec.email       = ["ortiz.mata.jorge@gmail.com"]
  spec.homepage    = "https://github.com/Jorge-Ortiz-Mata/manuable-project"
  spec.summary     = "Manuable Gem"
  spec.description = "Library linked to the FedEx services"
    spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://github.com/Jorge-Ortiz-Mata/manuable-project"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Jorge-Ortiz-Mata/manuable-project"
  spec.metadata["changelog_uri"] = "https://github.com/Jorge-Ortiz-Mata/manuable-project"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.4.3"
end
