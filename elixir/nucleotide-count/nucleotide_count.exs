defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    count_p(strand, nucleotide, 0)
  end

  defp count_p('', _, acc), do: acc
  defp count_p([n | rest], n, acc), do: count_p(rest, n, acc + 1)
  defp count_p([_ | rest], n, acc), do: count_p(rest, n, acc)

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    histogram_p(strand, %{?A => 0, ?T => 0, ?C => 0, ?G => 0})
  end

  defp histogram_p([], map), do: map

  defp histogram_p([n | rest], map),
    do: histogram_p(rest, Map.update!(map, n, &(&1 + 1)))
end
