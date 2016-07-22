require 'minitest/autorun'

class BeingLuckyStrategy

  # Three 1's => 1000 points
  # Three 6's =>  600 points
  # Three 5's =>  500 points
  # Three 4's =>  400 points
  # Three 3's =>  300 points
  # Three 2's =>  200 points
  # One   1   =>  100 points
  # One   5   =>   50 points

  SCORES = {
    "1" => -> (x) { x > 2 ? (x / 3) * 1000 + (x % 3)*100 : x * 100 },
    "5" => -> (x) { x > 2 ? (x / 3) * 500 + (x % 3)*50 : x * 50 },
    "2" => -> (x) { x > 2 ? (x / 3) * 200 : 0 },
    "3" => -> (x) { x > 2 ? (x / 3) * 300 : 0 },
    "4" => -> (x) { x > 2 ? (x / 3) * 400 : 0 },
    "6" => -> (x) { x > 2 ? (x / 3) * 600 : 0 }
  }

  def initialize(results)
    @pre_result = results.group_by(&:to_i)
                     .each_with_object({}) { |(k,v), hsh| hsh[k] = v.count }
  end

  def score
    @pre_result.map{|k,v| SCORES[k.to_s].call(v) }.reduce(&:+)
  end

end

describe BeingLuckyStrategy do
  it "[5,1,3,4,1]" do
    score = BeingLuckyStrategy.new([5,1,3,4,1]).score
    score.must_equal 250
  end
  it "[1,1,1,3,1]" do
    score = BeingLuckyStrategy.new([1,1,1,3,1]).score
    score.must_equal 1100
  end
  it "[2,4,4,5,4]" do
    score = BeingLuckyStrategy.new([2,4,4,5,4]).score
    score.must_equal 450
  end
  it " [1,1,1,1,1,1]" do
    score = BeingLuckyStrategy.new([1,1,1,1,1,1]).score
    score.must_equal 2000
  end
  it " [2,2,2,2,2,2]" do
    score = BeingLuckyStrategy.new([2,2,2,2,2,2]).score
    score.must_equal 400
  end

  it " [1,1,1,2,2,2]" do
    score = BeingLuckyStrategy.new([1,1,1,2,2,2]).score
    score.must_equal 1200
  end

  it " [1,2,3,5,1,1]" do
    score = BeingLuckyStrategy.new([1,2,3,5,1,1]).score
    score.must_equal 1050
  end

  it " [1,5,5,5,1,1]" do
    score = BeingLuckyStrategy.new([1,5,5,5,1,1]).score
    score.must_equal 1500
  end

  it "[5,5,5,5,5,5]" do
    score = BeingLuckyStrategy.new([5,5,5,5,5,5]).score
    score.must_equal 1000
  end

end
