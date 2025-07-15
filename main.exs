defmodule Main do
  Code.require_file("day1.exs")
  Code.require_file("day2.exs")
  Code.require_file("day3.exs")
  Code.require_file("day4.exs")
  Code.require_file("day5.exs")
  Code.require_file("day1x.exs")
  Code.require_file("day2x.exs")
  Code.require_file("day3x.exs")

  def main_f do
    day1 = File.read!("day1.txt")
    Day1.solve1(day1)
    Day1.solve2(day1)

    day2 = File.read!("day2.txt")
    Day2.solve1(day2)
    Day2.solve2(day2)

    day3 = File.read!("day3.txt")
    Day3.solve1(day3)

    {:ok, day4} = File.read("day4_dummy.txt")
    # Day4.solve1(day4)
    # Day4.part1(day4)

    {:ok, day5} = File.read("day5.txt")

    Day5.solve1(day5)

    ## advent of code 2020
    Day1x.solve1()
    Day1x.solve2()
    # Day2x.solve1()
    Day2x.solve2()
    Day3x.solve1()
    Day3x.solve2()
  end
end

Main.main_f()
