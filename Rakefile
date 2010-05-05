require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the zipcode_match plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the zipcode_match plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ZipcodeMatch'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = 'zipcodematch'
    gemspec.version = 1.0
    gemspec.summary = 'Validates hungarian zipcode easily.'
    gemspec.description = 'A rails plugin for searching and validating hungarian cities and zipcodes.'
    gemspec.author = 'Csiszár Attila'
    gemspec.email = %q{csiszar.ati@gmail.com}
    gemspec.homepage = %q{http://github.com/csiszarattila/zipcodematch}

    gemspec.add_dependency 'activerecord', '>=2.0.0'
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end