# The WeAre.Generator module provides functions to generate a list of items with random properties.
# The names for the items are taken from a YAML file.
defmodule WeAre.Generator do

  # The generate_items function generates a map containing a list of items.
  # Each item has random properties and a name taken from a YAML file.
  def generate_items do
    # Read the YAML file
    {:ok, yaml} = File.read(Application.app_dir(:wearegen, "priv/names.yaml"))
    # Parse the YAML data
    {:ok, data} = YamlElixir.read_from_string(yaml)

    # Generate a random number of items based on the YAML data
    items = Enum.map(5..Enum.random(5..15), fn _ -> generate_item(data) end)

    # Return the items in a map
    %{items: items}
  end

  # The generate_item function generates a single item with random properties.
  # The game_name and i18n names are taken from a randomly selected game from the YAML data.
  def generate_item(data) do
    # Select a random game from the data
    game = Enum.random(data)

    game_name = game["identifier"]
    # Construct the item
    %{
      "game_name" => game_name,
      "type" => Enum.random(["slots", "non-rng"]),
      "active" => Enum.random([0, 1]),
      "release_date" => generate_date(),
      "details" => %{
        "method" => generate_string(5),
        "popularity" => Enum.random(0..100),
        "image" => nil,
        "i18n" => %{
          "en" => game["title"],
          "ro" => game["title"]
        }
      }
    }
  end

  # The generate_string function generates a random string of the given length.
  defp generate_string(length \\ 10) do
    :crypto.strong_rand_bytes(length)
    |> Base.encode16()
    |> binary_part(0, length)
    |> String.downcase()
  end

  # The generate_date function generates a random date string in the "year-month-day" format.
  defp generate_date do
    # Generate a random number of days (up to a year)
    days = Enum.random(-365..365)

    # Get the current date
    date = Date.utc_today()

    # Add the random number of days to the current date
    new_date = Date.add(date, days)

    # Convert the date to a string in the "year-month-day" format
    Date.to_string(new_date)
  end

end