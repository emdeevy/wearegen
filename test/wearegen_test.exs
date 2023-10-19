defmodule WeAre.GeneratorTest do
  use ExUnit.Case

  describe "generate_items/1" do
    test "raises FunctionClauseError when n < 8" do
      assert_raise FunctionClauseError, fn ->
        WeAre.Generator.generate_items(4)
      end
    end

    test "generates the correct number of items" do
      items = WeAre.Generator.generate_items(10)
      assert length(items[:items]) <= 10
    end

    test "generates items with the correct keys" do
      items = WeAre.Generator.generate_items(10)
      Enum.each(items[:items], fn item ->
        assert Map.has_key?(item, "game_name")
        assert Map.has_key?(item, "type")
        assert Map.has_key?(item, "active")
        assert Map.has_key?(item, "release_date")
        assert Map.has_key?(item, "details")
      end)
    end

    test "generates items with the correct types" do
      items = WeAre.Generator.generate_items(10)
      Enum.each(items[:items], fn item ->
        assert is_binary(item["game_name"])
        assert is_binary(item["type"])
        assert item["active"] in [0, 1]
        assert is_binary(item["release_date"])
        assert is_map(item["details"])
      end)
    end
  end
end