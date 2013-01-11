require 'levenshtein'

class Device
  def self.devices
    raw = `tdtool -l`
    devices = raw.split("\n")
    devices[1..devices.length].map { |row| new(row) }
  end

  def self.find_by_name(name)
    name.gsub!(/\bthe\b/i, "")
    name.strip!
    device = devices.select { |device| device.name.downcase == name.downcase }[0]
    device || closest_match(name)
  end

  attr_reader :id, :name, :status
  attr_accessor :distance
  def initialize(data)
    @id, @name, @status = parse(data)
  end

  def execute(action)
    action.strip!
    if respond_to? action
      send(action) 
    else
      false
    end
  end


  def on
    system("tdtool --on #{@id}")
  end

  def off
    system("tdtool --off #{@id}")
  end

  def learn
    system("tdtool -e #{@id}")
  end

  def to_s
    "#{@id} #{@name} #{@status}"
  end

  private
  def parse(data)
    data.split("\t")
  end

  def self.closest_match(name)
    result = nil
    min_distance = 1000
    devices.each do | device|
      distance = Levenshtein.distance(device.name, name)
      if distance < min_distance
        result = device
        min_distance = distance
      end
    end
    result
  end
end
