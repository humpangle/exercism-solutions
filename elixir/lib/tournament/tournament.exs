defmodule Tournament do
  @first_win_data %{"MP" => 1, "W" => 1, "D" => 0, "L" => 0, "P" => 3}
  @first_draw %{"MP" => 1, "W" => 0, "D" => 1, "L" => 0, "P" => 1}
  @first_loss_data %{"MP" => 1, "W" => 0, "D" => 0, "L" => 1, "P" => 0}

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
    map = Enum.reduce(input, %{}, &compute_game_data/2)
    longest_team_len = String.length("Courageous Californians")

    data_rows =
      map
      |> Enum.sort(&sort_by_points/2)
      |> Enum.reduce([], fn {team, data}, acc ->
        [display_data_row(team, data, longest_team_len) | acc]
      end)

    ["Team                           | MP |  W |  D |  L |  P" | data_rows]
    |> Enum.join("\n")
  end

  defp compute_game_data(game_string, map) do
    case game_string |> String.trim() |> String.split(";") do
      [team1, team2, game_result] ->
        case game_result do
          "win" ->
            map |> team_won(team1) |> team_loss(team2)

          "draw" ->
            [team1, team2]
            |> Enum.reduce(
              map,
              &Map.update(&2, &1, @first_draw, fn team_data ->
                Map.merge(team_data, %{
                  "MP" => team_data["MP"] + 1,
                  "D" => team_data["D"] + 1,
                  "P" => team_data["P"] + 1
                })
              end)
            )

          "loss" ->
            map |> team_loss(team1) |> team_won(team2)

          _ ->
            map
        end

      _ ->
        map
    end
  end

  defp sort_by_points({k1, %{"P" => p1}}, {k2, %{"P" => p2}}),
    do: (p1 == p2 && k1 > k2) || p1 < p2

  defp display_data_row(team, data, longest_team_len) do
    spaces =
      longest_team_len
      |> Kernel.-(String.length(team))
      |> Kernel.+(8)

    [
      team,
      String.duplicate(" ", spaces),
      "|  ",
      Enum.map(["MP", "W", "D", "L", "P"], &data[&1]) |> Enum.join(" |  ")
    ]
    |> Enum.join()
  end

  defp team_won(%{} = data, team),
    do:
      Map.update(data, team, @first_win_data, fn team_data ->
        Map.merge(team_data, %{
          "MP" => team_data["MP"] + 1,
          "W" => team_data["W"] + 1,
          "P" => team_data["P"] + 3
        })
      end)

  defp team_loss(%{} = data, team),
    do:
      Map.update(data, team, @first_loss_data, fn val ->
        Map.merge(val, %{
          "MP" => val["MP"] + 1,
          "L" => val["L"] + 1
        })
      end)
end
