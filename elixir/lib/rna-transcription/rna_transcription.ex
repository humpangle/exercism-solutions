defmodule RNATranscription do
  @complements Enum.zip('GCTA', 'CGAU') |> Map.new()
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, &@complements[&1])
  end
end
