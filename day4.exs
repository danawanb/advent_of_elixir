defmodule Day4 do
  def solve1(s) do
    numx =
      s
      |> String.split("\n")
      |> hd()
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    board =
      s
      |> String.split("\n")
      |> tl()
      |> Enum.filter(fn s -> s != "" end)
      |> Enum.chunk_every(5)
      |> Enum.map(fn rw ->
        Enum.map(rw, fn cl ->
          cl
          |> String.split()
          |> Enum.map(&String.to_integer/1)
        end)
      end)
  end

  # unused
  def update_list(rawx, target) do
    Map.new(rawx, fn {key, val} ->
      if key in target, do: {key, 1}, else: {key, val}
    end)
  end

  def part1(input) do
    [numbers | boards] = String.split(input, "\n\n")

    numbers =
      String.split(numbers, ",")
      |> Enum.map(&String.to_integer/1)
      |> IO.inspect()

    boards =
      Enum.map(boards, &parse_board/1)
  end

  defp parse_board(board) do
    String.split(board, "\n")
    |> Enum.map(fn row ->
      String.split(row, " ")
      |> Enum.map(&String.to_integer/1)
      # |> Enum.map(fn value -> {:unmarked, value} end)
      |> IO.inspect()
    end)
  end
end
