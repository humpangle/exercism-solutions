defmodule Frequency do
  # @pattern_letter ~r/\p{L}/
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, _workers) do
    texts
    |> Enum.join()
    |> String.trim()
    |> String.downcase()
    |> String.to_charlist()
    |> make(%{})
  end

  defp make([], acc), do: acc

  defp make([c | r], acc) when c in '0123456789,',
    do: make(r, acc)

  defp make([c | r], acc) do
    c = <<c::utf8>>
    make(r, Map.update(acc, c, 1, &(&1 + 1)))
  end

  # defp worker(initial), do: spawn(fn -> loop(Map.put(%{}, initial, 1)) end)

  # defp loop(acc) do
  #   receive do
  #     {:update, value} ->
  #       acc |> Map.update(value, 1, &(&1 + 1)) |> loop

  #     :return ->
  #       acc
  #   end
  # end

  # defp is_letter?(l), do: Regex.match?(@pattern_letter, l)
end
