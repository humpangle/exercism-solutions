defmodule ISBNVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    case Regex.run(~r/^[\d]{9}[\dX]$/, String.replace(isbn, "-", "")) do
      nil ->
        false

      [string] ->
        string
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(0, fn
          {"X", _}, c -> c + 10
          {a, i}, c -> String.to_integer(a) |> Kernel.*(10 - i) |> Kernel.+(c)
        end)
        |> rem(11)
        |> Kernel.==(0)
    end
  end
end
