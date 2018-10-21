defmodule Bob do
  @pattern_letters ~r/\p{L}/

  def hey(input) do
    input = String.trim(input)

    cond do
      input == "" ->
        "Fine. Be that way!"

      String.ends_with?(input, "?") ->
        if yelling_question?(input) do
          "Calm down, I know what I'm doing!"
        else
          "Sure."
        end

      yelling?(input) ->
        "Whoa, chill out!"

      true ->
        "Whatever."
    end
  end

  defp are_letters?(s), do: Regex.match?(@pattern_letters, s)

  defp yelling?(s), do: String.upcase(s) == s && are_letters?(s)

  defp yelling_question?(s), do: String.upcase(s) == s && are_letters?(s)
end
