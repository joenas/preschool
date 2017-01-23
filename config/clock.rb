require 'clockwork'
require './config/boot'
require './config/environment'

# Make sure that all interactions and other things in this class are strictly asynchronous in nature.
# Keep them simple to limit the risk of having one of them crash and then the entire Clockwork process dies.

module Clockwork

  every(1.day, 'Do some stuff', at: '08.00') do
  end
end
