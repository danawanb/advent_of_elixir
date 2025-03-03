defmodule Day1 do
  def solve1(s) do
    s
    |> String.split("\n")
    |> Enum.filter(fn s -> s != "" end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [a, b], acc -> acc + is_add(a, b) end)
    |> IO.puts()
  end

  @spec is_add(number(), number()) :: number()
  def is_add(num1, num2), do: if(num2 > num1, do: 1, else: 0)

  def solve2(s) do
    s
    |> String.split("\n")
    |> Enum.filter(fn s -> s != "" end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(fn [a, b, c] -> a + b + c end)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [a, b], acc -> acc + is_add(a, b) end)
    |> IO.puts()
  end
end
