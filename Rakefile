require "bundler/gem_tasks"

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'lib/nice_bootstrap3_form'
  t.test_files = FileList['test/lib/nice_bootstrap3_form/*_test.rb']
  t.verbose = true
end

task default: :test
