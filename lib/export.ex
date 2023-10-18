defmodule WeAre.Exporter do
  def run do
    # Generate items
    items = WeAre.Generator.generate_items()

    # Convert to JSON and print
    items
    |> Jason.encode!()
    |> (&File.write!("./priv/items.json", &1)).()

  end
end