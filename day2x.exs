defmodule Day2x do
  def solve1() do
    txt =
      File.read!("day2x.txt")
      |> String.split("\n")
      |> List.delete_at(-1)
      |> Enum.map(fn x -> spliter(x) end)
      |> Enum.reduce(0, fn x, acc ->
        if x == true, do: acc + 1, else: acc
      end)

    IO.inspect(txt)
  end

  def spliter(val) do
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

    is_valid(String.to_integer(first), String.to_integer(second), charx, z)
  end

  def is_valid(min, max, charx, letter) do
    char_list = String.graphemes(letter)

    count =
      Enum.reduce(char_list, 0, fn x, acc ->
        if x == charx, do: acc + 1, else: acc
      end)

    count >= min and count <= max
  end
end
