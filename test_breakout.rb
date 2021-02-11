require 'minitest/autorun'
require 'minitest/reporters'
require './breakout.rb'
require './init_breakout.rb'

Output_file = "log_test"
# This works - writes output to file
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new(io: $stdout.reopen(Output_file, "w"))
# This doesnt work - not 100% sure why (got it from WellGrounded ch 12.1.3
# FIGURED IT OUT - File.open expects a block - it doesnt permanently redirect
# Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new(io: File.open("test2.txt", "w"))
class TestBreakout < Minitest::Test
  def setup
    @game = Game.new(test: true)

  end
  describe "draws bar initially" do

  end
  def test_test
    assert_equal 1, 2
  end
  describe "Hello" do
    it "knows 2+2" do
      value(2+2).must_equal 4
    end
  end
  
  def teardown
    @game = nil
    File.open(Output_file, "r") { |f| print f.read }
  end
end

