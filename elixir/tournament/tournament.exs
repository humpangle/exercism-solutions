defmodule Tournament do
  @initial_win %{"MP" => 1, "W" => 1, "D" => 0, "L" => 0, "P" => 3}
  @initial_draw %{"MP" => 1, "W" => 0, "D" => 1, "L" => 0, "P" => 1}
  @initial_loss %{"MP" => 1, "W" => 0, "D" => 0, "L" => 1, "P" => 0}

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    map =
      input
      |> Enum.reduce(%{}, fn s, map ->
        case s |> String.trim() |> String.split(";") do
          [t1, t2, status] ->
            case status do
              "win" ->
                map
                |> Map.update(t1, @initial_win, fn val ->
                  Map.merge(val, %{
                    "MP" => val["MP"] + 1,
                    "W" => val["W"] + 1,
                    "P" => val["P"] + 3
                  })
                end)
                |> Map.update(t2, @initial_loss, fn val ->
                  Map.merge(val, %{
                    "MP" => val["MP"] + 1,
                    "L" => val["L"] + 1
                  })
                end)

              "draw" ->
                [t1, t2]
                |> Enum.reduce(
                  map,
                  &Map.update(&2, &1, @initial_draw, fn val ->
                    Map.merge(val, %{
                      "MP" => val["MP"] + 1,
                      "D" => val["D"] + 1,
                      "P" => val["P"] + 1
                    })
                  end)
                )

              "loss" ->
                map
                |> Map.update(t1, @initial_loss, fn val ->
                  Map.merge(val, %{
                    "MP" => val["MP"] + 1,
                    "L" => val["L"] + 1
                  })
                end)
                |> Map.update(t2, @initial_win, fn val ->
                  Map.merge(val, %{
                    "MP" => val["MP"] + 1,
                    "W" => val["W"] + 1,
                    "P" => val["P"] + 3
                  })
                end)

              _ ->
                map
            end

          _ ->
            map
        end
      end)

    longest_team = 23

    lines =
      map
      |> Enum.sort(fn
        {<<k1, _::binary>>, %{"P" => p1}}, {<<k2, _::binary>>, %{"P" => p2}} ->
          cond do
            p1 == p2 -> k1 > k2
            true -> p1 < p2
          end
      end)
      |> Enum.reduce([], fn {team, data}, acc ->
        spaces =
          longest_team
          |> Kernel.-(String.length(team))
          |> Kernel.+(8)

        [
          [
            team,
            String.duplicate(" ", spaces),
            "|  ",
            data["MP"],
            " |  ",
            data["W"],
            " |  ",
            data["D"],
            " |  ",
            data["L"],
            " |  ",
            data["P"]
          ]
          |> Enum.join()
          | acc
        ]
      end)

    [
      "Team                           | MP |  W |  D |  L |  P" | lines
    ]
    |> Enum.join("\n")
  end
end
