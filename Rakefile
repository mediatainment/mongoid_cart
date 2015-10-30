begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

# rdoc
require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'MongoidCart'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

# used by rspec AND cucumber
APP_RAKEFILE = File.expand_path("../spec/test_app/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks

# statistic rake
load 'rails/tasks/statistics.rake'

# rspec
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new('spec')

# cucumber
task cucumber: 'app:cucumber'

# rake tasks
task default: [:spec, :cucumber]
