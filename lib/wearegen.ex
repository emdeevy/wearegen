defmodule WeAre.Generator do

  def generate_items(n \\ 20) when n >= 8 do
    {:ok, yaml} = File.read(Application.app_dir(:wearegen, "priv/names.yaml"))
    {:ok, data} = YamlElixir.read_from_string(yaml)

    required_items = [
      generate_item(data, "slots", :past, 1),
      generate_item(data, "slots", :past, 0),
      generate_item(data, "slots", :future, 1),
      generate_item(data, "slots", :future, 0),
      generate_item(data, "non-rng", :past, 1),
      generate_item(data, "non-rng", :past, 0),
      generate_item(data, "non-rng", :future, 1),
      generate_item(data, "non-rng", :future, 0)
    ]

    random_items = Enum.map(9..Enum.random(9..n), fn _ -> generate_random_item(data) end)

    %{items: required_items ++ random_items}
  end

  defp generate_random_item(data) do
    type = Enum.random(["slots", "non-rng"])
    time_period = Enum.random([:past, :future])
    active = Enum.random([0, 1])

    generate_item(data, type, time_period, active)
  end

  def generate_item(data, type, time_period, active) do
    game = Enum.random(data)
    game_name = game["identifier"]

    %{
      "game_name" => game_name,
      "type" => type,
      "active" => active,
      "release_date" => generate_date(time_period),
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

  defp generate_string(length \\ 10) do
    :crypto.strong_rand_bytes(length)
    |> Base.encode16()
    |> binary_part(0, length)
    |> String.downcase()
  end

  defp generate_date(time_period) do
    days = case time_period do
      :past -> Enum.random(-365..-1)
      :future -> Enum.random(1..365)
    end

    date = Date.utc_today()
    new_date = Date.add(date, days)

    Date.to_string(new_date)
  end

end