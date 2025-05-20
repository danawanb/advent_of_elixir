defmodule Day5 do
  def solve1(input) do
    numx =
      input
      |> String.replace(<<8>>, "8")
      |> String.replace(" ", "")
      |> String.split("\n")
      |> Enum.reject(&(String.trim(&1) == ""))
      |> Enum.map(&spliter2/1)
      |> Enum.filter(&is_straight_line/1)
      |> Enum.flat_map(&points_covered/1)
      |> Enum.frequencies()
      |> Enum.count(fn {_point, count} -> count >= 2 end)

    IO.puts(numx)
  end

  defp is_straight_line([[x1, y1], [x2, y2]]) do
    x1 == x2 or y1 == y2
  end

  def spliter2(s) do
    s
    |> String.split("->")
    |> Enum.map(fn pair ->
      pair
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp points_covered([[x1, y1], [x2, y2]]) do
    for x <- range_inclusive(x1, x2),
        y <- range_inclusive(y1, y2),
        do: {x, y}
  end

  defp range_inclusive(a, b) when a <= b, do: a..b
  defp range_inclusive(a, b), do: b..a |> Enum.reverse()

  def danawan do
    "bimantoro"
  end
end
