defmodule Words do
  @split_pattern ~r/(_|[^\w-])/u

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(@split_pattern, trim: true)
    |> Enum.reduce(%{}, &Map.update(&2, &1, 1, fn count -> count + 1 end))
  end
end
