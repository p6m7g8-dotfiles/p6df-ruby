# ~/.pryrc

# Enable syntax highlighting and autocompletion
Pry.config.color = true
Pry.config.completer = Pry::InputCompleter

# Pretty print objects automatically
Pry.config.print = proc { |output, value| output.puts value.ai }

# Set the history file using an environment variable
ENV['HISTFILE'] = "#{ENV['HOME']}/.pry_history"  # Set the history file location

# Define a custom prompt using the Pry::Prompt API
custom_prompt = Pry::Prompt.new(
  'custom',
  'A custom prompt for the Rails console',
  [
    proc { |obj, nest_level, _| "rails(#{obj}):#{nest_level}> " },
    proc { |obj, nest_level, _| "rails(#{obj}):#{nest_level}* " }
  ]
)

Pry.config.prompt = custom_prompt

# Reload the Rails environment easily
Pry::Commands.block_command 'reload!', 'Reload the Rails environment' do
  puts 'Reloading...'
  exec 'rails console'
end

# Alias for exiting the console
Pry::Commands.alias_command 'q', 'exit'

# Include useful gems like Awesome Print and Hirb
require 'awesome_print'
require 'hirb'

# Enable Hirb for table output formatting
Hirb.enable

