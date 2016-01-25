# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: r_hapi 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "r_hapi"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Tim Stephenson of RaddOnline"]
  s.date = "2016-01-25"
  s.description = "Makes it easy to use the HubSpot API in a Ruby application."
  s.email = "tim@raddonline.com"
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "README.md",
    "Rakefile",
    "VERSION",
    "fixtures/spec/RHapi_Contact/create/should_create_the_company.yml",
    "fixtures/spec/RHapi_Contact/create/should_create_the_contact.yml",
    "fixtures/spec/RHapi_Contact/find_by_company_id/should_be_able_to_find_the_company_by_HubSpot_ID_value.yml",
    "fixtures/spec/RHapi_Contact/recent/should_return_recent_contacts.yml",
    "fixtures/spec/RHapi_Contact/update/should_update_the_company_details.yml",
    "lib/r_hapi.rb",
    "lib/r_hapi/company.rb",
    "lib/r_hapi/configuration.rb",
    "lib/r_hapi/connection.rb",
    "lib/r_hapi/contact.rb",
    "lib/r_hapi/lead.rb",
    "lib/r_hapi/property.rb",
    "lib/r_hapi/r_hapi_exception.rb",
    "r_hapi.gemspec",
    "spec/lib/company_spec.rb",
    "spec/lib/contact_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/config.rb",
    "spec/vcr_helper.rb"
  ]
  s.homepage = "http://github.com/timstephenson/rHAPI"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.6"
  s.summary = "A ruby wrapper for the HubSpot API (HAPI)."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<curb>, [">= 0.8.8"])
      s.add_runtime_dependency(%q<json>, [">= 1.5.1"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<ir_b>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.5.0"])
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<jeweler>, [">= 1.5.2"])
      s.add_runtime_dependency(%q<curb>, ["~> 0.7.12"])
      s.add_runtime_dependency(%q<json>, [">= 1.5.1"])
      s.add_runtime_dependency(%q<activesupport>, [">= 0"])
    else
      s.add_dependency(%q<curb>, [">= 0.8.8"])
      s.add_dependency(%q<json>, [">= 1.5.1"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<ir_b>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.5.0"])
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<jeweler>, [">= 1.5.2"])
      s.add_dependency(%q<curb>, ["~> 0.7.12"])
      s.add_dependency(%q<json>, [">= 1.5.1"])
      s.add_dependency(%q<activesupport>, [">= 0"])
    end
  else
    s.add_dependency(%q<curb>, [">= 0.8.8"])
    s.add_dependency(%q<json>, [">= 1.5.1"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<ir_b>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.5.0"])
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<jeweler>, [">= 1.5.2"])
    s.add_dependency(%q<curb>, ["~> 0.7.12"])
    s.add_dependency(%q<json>, [">= 1.5.1"])
    s.add_dependency(%q<activesupport>, [">= 0"])
  end
end

