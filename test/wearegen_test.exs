defmodule WeAre.GeneratorTest do
  use ExUnit.Case

  # This will run before each test, changing the random seed to a known value
  setup do
    :rand.seed(:exsplus, {1, 2, 3})
    :ok
  end

  test "generate_items/0 returns a map with an :items key" do
    result = WeAre.Generator.generate_items()
    assert is_map(result)
    assert Map.has_key?(result, :items)
  end

  test "generate_items/0 returns between 1 and 10 items" do
    result = WeAre.Generator.generate_items()
    assert length(result.items) >= 1
    assert length(result.items) <= 10
  end

  test "generate_item/1 returns a map with the correct keys" do
    # You would replace this with a call to a function that returns your YAML data
    data = [%{"identifier" => "test", "title" => "Test"}]
    item = WeAre.Generator.generate_item(data)
    assert is_map(item)
    assert Map.has_key?(item, "game_name")
    assert Map.has_key?(item, "type")
    assert Map.has_key?(item, "active")
    assert Map.has_key?(item, "release_date")
    assert Map.has_key?(item, "details")
  end
end