defmodule Main do
  Code.require_file("day1.exs")
  Code.require_file("day2.exs")
  Code.require_file("day3.exs")

  def main_f do
    day1 = File.read!("day1.txt")
    Day1.solve1(day1)
    Day1.solve2(day1)

    day2 = File.read!("day2.txt")
    Day2.solve1(day2)
    Day2.solve2(day2)

    day3 = File.read!("day3.txt")
    Day3.solve1(day3)
  end
end

Main.main_f()
