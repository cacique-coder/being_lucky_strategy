defmodule BeingLuckyStrategy do
  def score(values) do
    calculation = %{
      1 => fn(x) -> div(x, 3) * 1000 + rem(x, 3) * 100 end,
      5 => fn(x) -> div(x, 3) * 500 + rem(x, 3) * 50 end,
      2 => fn(x) -> div(x, 3) * 200 end,
      3 => fn(x) -> div(x, 3) * 300 end,
      4 => fn(x) -> div(x, 3) * 400 end,
      6 => fn(x) -> div(x, 3) * 600 end
    }
    Enum.group_by(values, fn(x) -> x end)
    |> Enum.map(fn {k, list} -> {k, Enum.count(list)} end)
    |> Enum.reduce(0, fn ({item,quantity},acc) -> (Map.fetch!(calculation,item).(quantity) + acc) end)
  end
end
