defmodule Day2x do
  def solve1() do
    txt =
      File.read!("day2x.txt")
      |> String.split("\n")
      |> List.delete_at(-1)
      |> Enum.map(fn x -> spliter(x, 1) end)
      |> Enum.reduce(0, fn x, acc ->
        if x == true, do: acc + 1, else: acc
      end)

    IO.inspect(txt)
  end

  def spliter(val, flag) do
    res =
      val
      |> String.split(" ")

    [x, y, z] = res

    instanctes =
      x
      |> String.split("-")

    [first, second] = instanctes

    charx =
      y
      |> String.at(0)

    case flag do
      1 -> is_valid(String.to_integer(first), String.to_integer(second), charx, z)
      2 -> is_valid2(String.to_integer(first), String.to_integer(second), charx, z)
    end
  end

  def is_valid(min, max, charx, letter) do
    char_list = String.graphemes(letter)

    count =
      Enum.reduce(char_list, 0, fn x, acc ->
        if x == charx, do: acc + 1, else: acc
      end)

    count >= min and count <= max
  end

  def is_valid2(min, max, charx, letter) do
    char_idx =
      String.graphemes(letter)

    # IO.inspect(char_idx)

    minx =
      case Enum.fetch(char_idx, min - 1) do
        {:ok, val} -> if val == charx, do: 1, else: 0
        :error -> 0
      end

    maxx =
      case Enum.fetch(char_idx, max - 1) do
        {:ok, val} -> if val == charx, do: 1, else: 0
        :error -> 0
      end

    valx = minx + maxx

    if valx == 1 do
      true
    else
      false
    end
  end

  def solve2() do
    txt =
      File.read!("day2x.txt")
      |> String.split("\n")
      |> List.delete_at(-1)
      |> Enum.map(fn x -> spliter(x, 2) end)
      |> Enum.reduce(0, fn x, acc ->
        if x == true, do: acc + 1, else: acc
      end)

    IO.inspect(txt)
  end
end
