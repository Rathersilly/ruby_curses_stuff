#require './life'
require './life_plant'
require './life_helpers'
require 'minitest/autorun'

class TestWin
  include Helper
  attr_accessor :y, :x, :maxx, :maxy, :char
  def initialize(y = 0, x = 0)
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
Green = 13
Plant_image = "P"
Plants = []
Log = File.open("log", 'w')
Win = TestWin.new
Msg = ""

        Log.puts "start"
describe Plant do
  describe 'update' do
    before do
      @plant = Plant.new(10, 10)
      $stderr.puts "@plant: "
      $stderr.puts @plant.inspect
      Log.puts "#{ @plant.inspect}"
      Log.puts "hi"
    end

    it 'should die when max_age' do
      @plant.age = @plant.max_age
      assert_nil(@plant.update)
    end
    it 'should replicate' do
      num_plants = Plants.size
      @plant.replicate = 0
      @plant.update
      
      assert_equal(@plant.replicate, @plant.rep_interval)
      assert_equal(Plants.size - num_plants, 1)
    end
  end
end
describe Helper do
  describe "oob?" do
    before do
      Win = TestWin.new
    end
    it 'should report oob with array arg' do
      assert(Win.oob?([-1,10]), true)
      assert(Win.oob?([10,-10]), true)
      assert(Win.oob?([10,Win.maxx]), true)
      assert(Win.oob?([Win.maxy,10]), true)
      assert(Win.oob?([Win.maxy,Win.maxx]), true)
      assert_equal(Win.oob?([10,10]), false)
    end
    it 'should report Win.oob with 2 int args' do
      assert(Win.oob?(-1,10), true)
      assert(Win.oob?(10,-10), true)
      assert(Win.oob?(10,Win.maxx), true)
      assert(Win.oob?(Win.maxy,10), true)
      assert(Win.oob?(Win.maxy,Win.maxx), true)
      assert_equal(Win.oob?(10,10), false)
    end
  end
end


