defmodule Bob do
  @pattern_not_integer ~r/^[^\d]/
  @pattern_no_end_with_number ~r/[^\d]$/

  def hey(""), do: "Fine. Be that way!"

  def hey(input) do
    input = String.trim(input)

    cond do
      input == "" ->
        "Fine. Be that way!"

      String.upcase(input) == input && String.ends_with?(input, "?") and
          Regex.match?(@pattern_not_integer, input) ->
        "Calm down, I know what I'm doing!"

      Regex.match?(@pattern_no_end_with_number, input) && String.upcase(input) == input &&
          not String.ends_with?(input, "?") ->
        "Whoa, chill out!"

      String.ends_with?(input, "?") ->
        "Sure."

      true ->
        "Whatever."
    end
  end
end
