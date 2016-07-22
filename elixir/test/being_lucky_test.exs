defmodule BeingLuckyStrategyTest do
  use ExUnit.Case
  doctest BeingLuckyStrategy

  test "[1,1,1,1,1]" do
    BeingLuckyStrategy.score([1, 1, 1, 1, 1]) == 1200
  end

  test "[5,1,3,4,1]" do
    BeingLuckyStrategy.score([5, 1, 3, 4, 1]) == 250
  end

  test "[1,1,1,3,1]" do
    BeingLuckyStrategy.score([1, 1, 1, 3, 1]) == 1100
  end
end
