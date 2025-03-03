defmodule Day3 do
  def solve1(s) do
    list_s =
      s
      |> String.split("\n")
      |> Enum.filter(fn s -> s != "" end)
      |> Enum.map(&String.graphemes/1)

    most_freq =
      0..11
      |> Enum.map(fn index ->
        list_s
        |> Enum.map(&Enum.at(&1, index))
        |> Enum.frequencies()
        |> Enum.max_by(fn {_letter, count} -> count end)
        |> elem(0)
      end)

    least_freq =
      0..11
      |> Enum.map(fn index ->
        list_s
        |> Enum.map(&Enum.at(&1, index))
        |> Enum.frequencies()
        |> Enum.min_by(fn {_letter, count} -> count end)
        |> elem(0)
      end)

    (parse_binary(most_freq) * parse_binary(least_freq))
    |> IO.inspect()
  end

  def parse_binary(s) do
    Enum.join(s, "")
    |> Integer.parse(2)
    |> elem(0)
  end
end
