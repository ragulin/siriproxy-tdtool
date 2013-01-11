require 'cora'
require 'siri_objects'
require 'pp'
require_relative 'device.rb'

class SiriProxy::Plugin::TdTool < SiriProxy::Plugin

  listen_for /turn (\w+) (.*)/i do |action, name|
    if name.strip == "everything"
      Device.devices.each { |device| device.execute(action) }
      respond
    else
      device = Device.find_by_name(name)
      unless device.nil?
        device.execute(action)
        respond
      else
        say "Couldn't find any device named #{name}"
      end
    end
    request_completed 
  end

  def respond 
    responses = ["Sir, yes, sir!", "There you go"]
    say responses.sample
  end

  listen_for /list devices.*/i do
    say "Configured devices\n#{Device.devices.join("\n")}"
    request_completed 
  end
end
