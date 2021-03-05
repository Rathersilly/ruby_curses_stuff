#require './life'
require './life_plant'
require 'minitest/autorun'

class Testwin
  attr_accessor :y, :x, :maxx, :maxy, :char

  def initialize
    @char = ' '
    @y = y
    @x = x
    @maxx = 100
    @maxy = 100
  end

  def inch
    @char.ord
  end
  def setpos(y,x)
  end
  def <<(x)
  end

end

describe Plant do
  describe 'update' do
    before do
      begin
        Green = 13
        Plants = []
        Log = File.open("log", 'w')
        Win = Testwin.new
        Msg = ""
        @plant = Plant.new(10, 10)
        Log.puts "#{ @plant.inspect}"
      rescue StandardError
      end
    end

    it 'should die when max_age' do
      @plant.age = @plant.max_age
      assert_nil(@plant.update)
    end
    it 'should replicate' do
      @plant.replicate = 0
      @plant.update
      assert_equal(@plant.replicate, @plant.rep_interval)
    end
  end
end
