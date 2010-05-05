# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{zipcodematch}
  s.version = "1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Csisz\303\241r Attila"]
  s.date = %q{2010-05-05}
  s.default_executable = %q{rake}
  s.description = %q{A rails plugin for searching and validating hungarian cities and zipcodes.}
  s.email = %q{csiszar.ati@gmail.com}
  s.executables = ["rake"]
  s.extra_rdoc_files = [
    "README.html",
     "README.md"
  ]
  s.files = [
    "MIT-LICENSE",
     "README.md",
     "Rakefile",
     "generators/zipcodes/templates/migration.rb",
     "generators/zipcodes/zipcodes_generator.rb",
     "init.rb",
     "install.rb",
     "lib/data/budapest.csv",
     "lib/data/debrecen.csv",
     "lib/data/gyor.csv",
     "lib/data/miskolc.csv",
     "lib/data/pecs.csv",
     "lib/data/szeged.csv",
     "lib/data/telepulesek.csv",
     "lib/mocks/zipcode_match.rb",
     "lib/models/zipcode.rb",
     "lib/progressbar.rb",
     "lib/zipcode_match.rb",
     "tasks/zipcode_match_tasks.rake",
     "test/debug.log",
     "test/schema.rb",
     "test/test_helper.rb",
     "test/zipcode_match_test.rb",
     "uninstall.rb"
  ]
  s.homepage = %q{http://github.com/csiszarattila/zipcodematch}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Validates hungarian zipcode easily.}
  s.test_files = [
    "test/schema.rb",
     "test/test_helper.rb",
     "test/zipcode_match_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 2.0.0"])
    else
      s.add_dependency(%q<activerecord>, [">= 2.0.0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 2.0.0"])
  end
end

