defmodule ScaleGenerator do
  @step %{"m" => 1, "M" => 2, "F" => 3}
  @notes 'ABCDEFG'
         |> Enum.with_index()
         |> Enum.map(fn {l, index} -> {index, <<l::utf8>>} end)
         |> Enum.into(%{})
  @doc """
  Find the note for a given interval (`step`) in a `scale` after the `tonic`.

  "m": one semitone
  "M": two semitones (full tone)
  "A": augmented second (three semitones)

  Given the `tonic` "D" in the `scale` (C C# D D# E F F# G G# A A# B C), you
  should return the following notes for the given `step`:

  "m": D#
  "M": E
  "A": F
  """
  @spec step(
          scale :: list(String.t()),
          tonic :: String.t(),
          step :: String.t()
        ) :: String.t()
  def step(scale, tonic, step) do
    tonic_index = Enum.find_index(scale, &(&1 == tonic))
    tonic_step_index = (@step[step] || 3) + tonic_index
    Enum.at(scale, tonic_step_index)
  end

  @doc """
  The chromatic scale is a musical scale with thirteen pitches, each a semitone
  (half-tone) above or below another.

  Notes with a sharp (#) are a semitone higher than the note below them, where
  the next letter note is a full tone except in the case of B and E, which have
  no sharps.

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C C# D D# E F F# G G# A A# B C)
  """
  @spec chromatic_scale(tonic :: String.t()) :: list(String.t())
  def chromatic_scale(tonic \\ "C") do
    tonic = String.capitalize(tonic)
    {index, _} = Enum.find(Map.to_list(@notes), fn {_, l} -> l == tonic end)

    index..6
    |> Enum.concat(0..index)
    |> Enum.reduce([[], []], fn index, [acc, indices] ->
      l = @notes[index]
      acc = [l | acc]

      acc =
        if l == "B" || l == "E" || index in indices,
          do: acc,
          else: [l <> "#" | acc]

      [acc, [index | indices]]
    end)
    |> hd()
    |> Enum.reverse()
  end
end
