defmodule Words do
  @split_pattern ~r/[\s_]/
  @word_pattern ~r/[\w\d]/

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.split(@split_pattern)
    |> Enum.reduce(Map.new(), fn raw_word, acc ->
      case check(String.codepoints(raw_word), "") do
        "" -> acc
        word -> Map.update(acc, word, 1, &(&1 + 1))
      end
    end)
  end

  defp check([], word) do
    String.downcase(word)
  end

  defp check(["-" | words], word), do: check(words, <<word::binary, "-">>)

  defp check([l | words], word) do
    case Regex.match?(@word_pattern, l) do
      true ->
        check(words, <<word::binary, l::binary>>)

      _ ->
        check(words, word)
    end
  end
end
