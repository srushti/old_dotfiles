require 'rake'

FILES = %w(ackrc editrc gemrc irbrc zshrc)

desc "Copy the files as ~/.*rc"
task :install do
  FILES.each do |file|
    #p file, File.join(ENV['HOME'], ".#{file}")
    FileUtils.cp file, File.join(ENV['HOME'], ".#{file}"), :verbose => true
  end
end

task :default => :install
