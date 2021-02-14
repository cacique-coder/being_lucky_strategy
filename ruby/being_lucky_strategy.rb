require 'minitest/autorun'

class BeingLuckyStrategy
  def initialize(results)
    @results = results
  end

  def score
    dice_count_map.map{|dice_value, counting| get_score_by(dice_value, counting) }.sum(0)
  end

  private

  attr_reader :results

  def dice_count_map
    @dice_count_map ||=
      results.group_by(&:to_i)
             .each_with_object({}) { |(dice, dice_result), hsh| hsh[dice] = dice_result.count }
  end

    # Three 1's => 1000 points
  # Three 6's =>  600 points
  # Three 5's =>  500 points
  # Three 4's =>  400 points
  # Three 3's =>  300 points
  # Three 2's =>  200 points
  # One   1   =>  100 points
  # One   5   =>   50 points

  def get_score_by(dice, count)
    case dice.to_s
    when "1"
      (count / 3) * 1000 + (count % 3)*100
    when "5"
      (count / 3) * 500 + (count % 3)*50
    when "2"
      (count / 3) * 200
    when "3"
      (count / 3) * 300
    when "4"
      (count / 3) * 400
    when "6"
      (count / 3) * 600
    else
      0
    end
  end
end

describe BeingLuckyStrategy do
  it "[5,1,3,4,1]" do
    score = BeingLuckyStrategy.new([5,1,3,4,1]).score
    _(score).must_equal 250
  end
  it "[1,1,1,3,1]" do
    score = BeingLuckyStrategy.new([1,1,1,3,1]).score
    _(score).must_equal 1100
  end
  it "[2,4,4,5,4]" do
    score = BeingLuckyStrategy.new([2,4,4,5,4]).score
    _(score).must_equal 450
  end
  it " [1,1,1,1,1,1]" do
    score = BeingLuckyStrategy.new([1,1,1,1,1,1]).score
    _(score).must_equal 2000
  end
  it " [2,2,2,2,2,2]" do
    score = BeingLuckyStrategy.new([2,2,2,2,2,2]).score
    _(score).must_equal 400
  end

  it " [1,1,1,2,2,2]" do
    score = BeingLuckyStrategy.new([1,1,1,2,2,2]).score
    _(score).must_equal 1200
  end

  it " [1,2,3,5,1,1]" do
    score = BeingLuckyStrategy.new([1,2,3,5,1,1]).score
    _(score).must_equal 1050
  end

  it " [1,5,5,5,1,1]" do
    score = BeingLuckyStrategy.new([1,5,5,5,1,1]).score
    _(score).must_equal 1500
  end

  it "[5,5,5,5,5,5]" do
    score = BeingLuckyStrategy.new([5,5,5,5,5,5]).score
    _(score).must_equal 1000
  end

end
