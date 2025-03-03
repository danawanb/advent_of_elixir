defmodule Day2 do
  def solve1(s) do
    res =
      s
      |> String.split("\n")
      |> Enum.filter(fn s -> s != "" end)
      |> Enum.map(fn x -> String.split(x, " ") end)
      |> Enum.map(fn x -> {Enum.at(x, 0), String.to_integer(Enum.at(x, 1))} end)
      |> Enum.map_reduce(%{h: 0, v: 0}, fn x, acc -> move(x, acc) end)
      |> elem(1)

    (Map.get(res, :h) * Map.get(res, :v))
    |> IO.inspect()
  end

  def move({dir, num}, %{h: h, v: v}) do
    case dir do
      "forward" -> {num, %{h: h + num, v: v}}
      "down" -> {num, %{h: h, v: v + num}}
      "up" -> {num, %{h: h, v: v - num}}
      _ -> {0, %{h: h, v: v}}
    end
  end

  def solve2(s) do
    res =
      s
      |> String.split("\n")
      |> Enum.filter(fn s -> s != "" end)
      |> Enum.map(fn x -> String.split(x, " ") end)
      |> Enum.map(fn x -> {Enum.at(x, 0), String.to_integer(Enum.at(x, 1))} end)
      |> Enum.map_reduce(%{h: 0, v: 0, aim: 0, depth: 0}, fn x, acc -> movex(x, acc) end)
      |> elem(1)

    (Map.get(res, :h) * Map.get(res, :depth))
    |> IO.inspect()
  end

  def movex({dir, num}, %{h: h, v: v, aim: aim, depth: depth}) do
    case dir do
      "forward" -> {num, %{h: h + num, v: v, aim: aim, depth: depth + aim * num}}
      "down" -> {num, %{h: h, v: v, aim: aim + num, depth: depth}}
      "up" -> {num, %{h: h, v: v, aim: aim - num, depth: depth}}
      _ -> {0, %{h: h, v: v, aim: aim, depth: depth}}
    end
  end
end
