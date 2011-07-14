require 'rake'

FILES = %w(ackrc editrc gemrc irbrc zshrc)
DIRS = %w(zsh)

desc "Copy the files as ~/.*rc"
task :install do
  FILES.each do |file|
    link_if_it_doesnt_exist(file, 'f')
  end
  DIRS.each {|dir| link_if_it_doesnt_exist(dir, 'd')}
end

def link_if_it_doesnt_exist(file, condition)
  system(<<-EOSCRIPT
    if [ ! -#{condition} $HOME/.#{file} ]; then
      ln -s $PWD/#{file} $HOME/.#{file}
      echo "Linking .#{file}"
    else
      echo "Skipping .#{file}, it already exists"
    fi
  EOSCRIPT
        )
end

task :default => :install
