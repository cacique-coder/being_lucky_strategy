defmodule BeingLuckyTest do
  use ExUnit.Case
  doctest BeingLucky

  test "[1,1,1,1,1]" do
    BeingLucky.score([1, 1, 1, 1, 1]) == 1200
  end

  test "[5,1,3,4,1]" do
    BeingLucky.score([5, 1, 3, 4, 1]) == 250
  end

  test "[1,1,1,3,1]" do
    BeingLucky.score([1, 1, 1, 3, 1]) == 1100
  end
end
