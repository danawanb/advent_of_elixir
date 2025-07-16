defmodule Day4x do
  def solve1() do
    res =
      File.read!("day4x.txt")
      |> String.split("\n\n")
      |> Enum.map(fn x -> String.replace(x, "\n", " ") end)
      |> Enum.map(fn x -> spliter(x) end)
      |> Enum.filter(fn x -> x == true end)
      |> Enum.count()
      |> IO.inspect()
  end

  def spliter(val) do
    val
    |> String.split(" ")
    |> Enum.map(fn x -> get_field_val(x) end)
    |> Enum.map(fn x -> Map.keys(x) end)
    |> List.flatten()
    |> check_vaid()
  end

  def get_field_val(val) do
    val_list =
      val
      |> String.split(":")

    keyx = Enum.at(val_list, 0)
    valx = Enum.at(val_list, 1)

    result = Map.new()
    new_result = Map.put(result, keyx, valx)
    new_result
  end

  defp check_vaid(val) do
    required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    Enum.all?(required, fn item -> item in val end)
  end

  def solve2() do
    res =
      File.read!("day4x.txt")
      |> String.split("\n\n")
      |> Enum.map(fn x -> String.replace(x, "\n", " ") end)
      |> Enum.map(fn x -> spliter2(x) end)
      |> Enum.filter(fn x -> x == true end)
      |> Enum.count()
      |> IO.inspect()

    # |> Enum.filter(fn x -> x == true end)
    # |> Enum.count()
    # |> IO.inspect()
  end

  def spliter2(val) do
    val
    |> String.split(" ")
    |> Enum.map(fn x -> get_field_val(x) end)
    |> check_valid2()
    |> IO.inspect()

    # |> Enum.map(fn x -> Map.keys(x) end)

    # |> List.flatten()
    # |> check_vaid()
  end

  def check_valid2(val) do
    required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

    key_only =
      val
      |> Enum.map(fn x -> Map.keys(x) end)
      |> List.flatten()
      |> Enum.filter(fn x -> x != "" end)

    is_valid = Enum.all?(required, fn item -> item in key_only end)

    if is_valid do
      merged =
        Enum.reduce(val, %{}, fn map, acc ->
          Map.merge(acc, map)
        end)

      byr = Map.get(merged, "byr")
      int_byr = String.to_integer(byr)

      is_byr_valid =
        if int_byr >= 1920 and int_byr <= 2002 do
          true
        else
          false
        end

      iyr = Map.get(merged, "iyr")
      int_iyr = String.to_integer(iyr)

      is_iyr_valid =
        if int_iyr >= 2010 and int_iyr <= 2020 do
          true
        else
          false
        end

      eyr = Map.get(merged, "eyr")
      int_eyr = String.to_integer(eyr)

      is_eyr_valid =
        if int_eyr >= 2020 and int_eyr <= 2030 do
          true
        else
          false
        end

      hgt = Map.get(merged, "hgt")
      is_hgt_valid = parse_heightx(hgt)

      hcl = Map.get(merged, "hcl")
      is_hcl_valid = String.match?(hcl, ~r/^#[0-9a-f]{6}$/)

      ecl = Map.get(merged, "ecl")
      is_ecl_valid = parse_hcl(ecl)

      pid = Map.get(merged, "pid")
      is_pid_valid = String.match?(pid, ~r/[0-9]/) and String.length(pid) == 9

      is_byr_valid and is_iyr_valid and is_eyr_valid and is_hgt_valid and is_hcl_valid and
        is_ecl_valid and is_pid_valid
    else
      false
    end
  end

  def parse_height(str_height) do
    c_in = String.contains?(str_height, "in")
    c_cm = String.contains?(str_height, "cm")
    IO.inspect(str_height)

    if c_in == true or c_cm == true do
      if c_in == true do
        height = String.replace(str_height, "in", "")
        IO.inspect(height)
        int_height = String.to_integer(height)
        IO.inspect(int_height)

        if int_height >= 59 and int_height <= 76 do
          IO.inspect("TRUE")
          true
        else
          false
        end
      end

      if c_cm == true do
        height = String.replace(str_height, "cm", "")
        int_height = String.to_integer(height)

        if int_height >= 150 and int_height <= 193 do
          true
        else
          false
        end
      end
    else
      false
    end
  end

  def parse_heightx(str_height) do
    cond do
      String.ends_with?(str_height, "in") ->
        height = String.replace(str_height, "in", "")
        int_height = String.to_integer(height)

        int_height >= 59 and int_height <= 76

      String.ends_with?(str_height, "cm") ->
        height = String.replace(str_height, "cm", "")
        int_height = String.to_integer(height)

        int_height >= 150 and int_height <= 193

      true ->
        false
    end
  end

  def parse_hcl(hcl) do
    valid_hair = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

    Enum.any?(valid_hair, fn x -> x == hcl end)
  end
end
