defmodule Day3x do
  def solve1() do
    grid =
      File.read!("day3x.txt")
      |> String.split("\n")
      |> List.delete_at(-1)
      |> Enum.map(fn x ->
        String.graphemes(x)
      end)

    lastx = get_last(grid)
    movex(grid, 0, 0, elem(lastx, 0), elem(lastx, 1), 0) |> IO.inspect()
  end

  def get_last(grid) do
    y = Enum.count(grid)
    x = Enum.count(Enum.at(grid, 0))
    {x - 1, y - 1}
  end

  def movex(grid, curr_x, curr_y, last_x, last_y, new_val) do
    if curr_y > last_y do
      new_val
    else
      rows = Enum.at(grid, curr_y)
      width = length(rows)

      # x = rem(curr_x, width)
      x =
        if curr_x >= width do
          curr_x - width * div(curr_x, width)
        else
          curr_x
        end

      cur_col = Enum.at(rows, x)

      new_val =
        if cur_col == "#" do
          new_val + 1
        else
          new_val
        end

      movex(grid, curr_x + 3, curr_y + 1, last_x, last_y, new_val)
    end
  end

  def solve2() do
    grid =
      File.read!("day3x.txt")
      |> String.split("\n")
      |> List.delete_at(-1)
      |> Enum.map(fn x ->
        String.graphemes(x)
      end)

    lastx = get_last(grid)

    slopes = [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]

    res_solve2 =
      Enum.map(slopes, fn {right, down} ->
        movexx(grid, 0, 0, elem(lastx, 0), elem(lastx, 1), 0, right, down)
      end)
      |> Enum.reduce(fn x, acc -> x * acc end)
      |> IO.inspect()
  end

  def movexx(grid, curr_x, curr_y, last_x, last_y, new_val, right, down) do
    if curr_y > last_y do
      new_val
    else
      rows = Enum.at(grid, curr_y)
      width = length(rows)

      # x = rem(curr_x, width)
      x =
        if curr_x >= width do
          curr_x - width * div(curr_x, width)
        else
          curr_x
        end

      cur_col = Enum.at(rows, x)

      new_val =
        if cur_col == "#" do
          new_val + 1
        else
          new_val
        end

      movexx(grid, curr_x + right, curr_y + down, last_x, last_y, new_val, right, down)
    end
  end
end
