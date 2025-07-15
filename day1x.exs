defmodule Day1x do
  @doc """
    Advent of code 2020 day 1
  """

  def solve1() do
    day1 =
      File.read!("day1x.txt")
      |> String.split("\n")
      |> List.delete_at(-1)
      |> Enum.map(&String.to_integer/1)
      |> combinations(2)
      |> Enum.filter(fn [x, y] -> x + y == 2020 end)
      |> Enum.fetch!(0)

    [first, sec] = day1
    IO.inspect("solve1 #{first * sec}")
  end

  def solve2() do
    day1 =
      File.read!("day1x.txt")
      |> String.split("\n")
      |> List.delete_at(-1)
      |> Enum.map(&String.to_integer/1)
      |> combinations(3)
      |> Enum.filter(fn [x, y, z] -> x + y + z == 2020 end)
      |> Enum.fetch!(0)

    [first, sec, third] = day1
    IO.inspect("solve2 #{first * sec * third}")
  end

  defp combinations(_, 0), do: [[]]
  defp combinations([], _), do: []

  defp combinations([head | tail], k) do
    with_head = combinations(tail, k - 1) |> Enum.map(&[head | &1])
    without_head = combinations(tail, k)
    with_head ++ without_head
  end
end
