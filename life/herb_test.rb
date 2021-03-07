#require './life'
require './life_plant'
require './life_herb'
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
  def refresh
  end
end
Green = 13
Yellow = 13
Plant_image = "P"
Plants = []
Herbs = []
OldPos = []
Log = File.open("log", 'w')
Win = TestWin.new
Msg = ""

describe Herb do
  describe 'update' do
    before do
      @herb = Herb.new(10, 10)
      $stderr.print "@herb: "
      $stderr.puts @herb.inspect
      Log.puts "#{ @herb.inspect}"
    end

    it 'should die when max_age' do
      @herb.age = @herb.max_age
      assert_nil(@herb.update)
    end
    it 'should be hungry or idle' do
      @herb.hunger = 1
      $stderr.puts "herbstate"
      $stderr.puts @herb.state
      @herb.update
      assert_equal(@herb.state, :idle)
      @herb.hunger = @herb.hunger_threshold + 1
      @herb.update
      assert_equal(@herb.state, :hungry)
    end
    it 'should approach target' do
      tar = Target.new(rand(Win.maxy),rand(Win.maxx))
      $stderr.puts tar.inspect
      @herb.target = tar
      old_dy = (@herb.y - tar.y).abs
      old_dx = (@herb.x - tar.x).abs
      $stderr.puts "#{old_dy}, #{old_dx}"
      @herb.update
      dy = (@herb.y - tar.y).abs
      dx = (@herb.x - tar.x).abs
      $stderr.puts "#{dy}, #{dx}"
      assert(dy <= old_dy)
      assert(dx <= old_dx)
    end
    it 'should find target if target is nil' do
      @herb.target = nil
      @herb.state = :idle
      @herb.update
      assert_equal(@herb.target.class, Target)
    end
    it 'should replicate' do
      num_herbs = Herbs.size
      @herb.replicate = 0
      @herb.update
      
      #assert_equal(@herb.replicate, @herb.rep_interval)
      #assert_equal(Herbs.size - num_herbs, 1)
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



