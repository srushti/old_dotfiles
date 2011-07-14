require 'rubygems'
#rails3: be sure to include wirble and hirb in your Gemfile
$:.unshift "~/.rvm/gems/ruby-1.9.2-p180@irb/gems/hirb-0.4.5/lib"
$:.unshift "~/.rvm/gems/ruby-1.9.2-p180@irb/gems/wirble-0.1.3/lib"
$:.unshift "~/.rvm/gems/ruby-1.9.2-p180@irb/gems/interactive_editor-0.0.8/lib"
require 'wirble'
require 'hirb'
require 'interactive_editor'

Wirble.init
Wirble.colorize

# hirb (active record output format in table)
Hirb::View.enable


# IRB Options
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200


#rails2
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  # Log to STDOUT if in Rails
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  #IRB.conf[:USE_READLINE] = true

  # Display the RAILS ENV in the prompt
  # ie : [Development]>>
  IRB.conf[:PROMPT][:CUSTOM] = {
   :PROMPT_N => "[#{ENV["RAILS_ENV"].capitalize}]>> ",
   :PROMPT_I => "[#{ENV["RAILS_ENV"].capitalize}]>> ",
   :PROMPT_S => nil,
   :PROMPT_C => "?> ",
   :RETURN => "=> %s\n"
   }
  # Set default prompt
  IRB.conf[:PROMPT_MODE] = :CUSTOM
#rails3
elsif defined?(Rails)
  require 'logger'
  Rails.logger=Logger.new(STDOUT)
  #IRB.conf[:USE_READLINE] = true

  # Display the RAILS ENV in the prompt
  # ie : [Development]>>
  IRB.conf[:PROMPT][:CUSTOM] = {
   :PROMPT_N => "[#{Rails.env.capitalize}]>> ",
   :PROMPT_I => "[#{Rails.env.capitalize}]>> ",
   :PROMPT_S => nil,
   :PROMPT_C => "?> ",
   :RETURN => "=> %s\n"
   }
  # Set default prompt
  IRB.conf[:PROMPT_MODE] = :CUSTOM
end

class Object
  def _methods
    (methods - Object.methods).sort
  end

  def _instance_methods
    (instance_methods - Object.new.methods).sort
  end
end

