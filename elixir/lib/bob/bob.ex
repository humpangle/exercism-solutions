defmodule Bob do
  @pattern_letters ~r/\p{L}/
  def hey(input) do
    input = String.trim(input)

    cond do
      input == "" ->
        "Fine. Be that way!"

      yelling?(input) ->
        if String.ends_with?(input, "?"),
          do: "Calm down, I know what I'm doing!",
          else: "Whoa, chill out!"

      String.ends_with?(input, "?") ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  defp yelling?(s),
    do: Regex.match?(@pattern_letters, s) && String.upcase(s) == s
end
