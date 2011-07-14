require 'rake'

FILES = %w(ackrc editrc gemrc irbrc zshrc)

desc "Copy the files as ~/.*rc"
task :install do
  FILES.each do |file|
    system(<<-EOSCRIPT
      if [ ! -f $HOME/.#{file} ]; then
        ln -s $PWD/#{file} $HOME/.#{file}
        echo "Linking .#{file}"
      else
        echo "Skipping .#{file}, it already exists"
      fi
    EOSCRIPT
          )
  end
end

task :default => :install
