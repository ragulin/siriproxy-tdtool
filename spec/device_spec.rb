require "minitest/autorun"
require "minitest/spec"
require "minitest/pride"

require_relative "../lib/device.rb"

describe Device do
  before do
    module Kernel
      def `(cmd)
        "Number of devices: 3\n1\tKitchen\tON\n2\tLivingroom\tOFF\n3\tBedroom\tOFF\n\n"
      end
    end
  end

  describe ".devices" do
    it "returns all configured devices" do
      Device.devices.length.must_equal 3
    end

    it "only returns device instances" do
      Device.devices.each { |device|  device.must_be_instance_of Device }
    end
  end

  describe ".find_by_name" do
    it "finds the device with the given name" do
      device = Device.find_by_name("Kitchen")
      device.name.must_equal "Kitchen"
    end

    it "is case insensitive" do
      device = Device.find_by_name("kitchen")
      device.name.must_equal "Kitchen"
    end

    it "discards 'the'" do
      device = Device.find_by_name("the kitchen")
      device.name.must_equal "Kitchen"
    end

    it "returns the closest match if no exact match is found" do
      device = Device.find_by_name("living room")
      device.name.must_equal "Livingroom"
    end
  end

  it "parses an row correct" do
    device = Device.new("1\tKitchen\tON")
    device.id.must_equal "1"
    device.name.must_equal "Kitchen"
    device.status.must_equal "ON"
  end
end
