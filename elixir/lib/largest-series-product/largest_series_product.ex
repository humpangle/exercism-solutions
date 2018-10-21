defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product1(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product1(_, 0), do: 1

  def largest_product1(number_string, size) do
    if size < 1 || String.length(number_string) < size do
      raise ArgumentError
    else
      largest_prod(number_string, (size - 1) * 8, 0)
    end
  end

  defp largest_prod(largest), do: largest

  defp largest_prod(string, size, current_largest) do
    case string do
      <<first::utf8, next::size(size), rest::binary>> ->
        largest_prod(
          <<next::size(size), rest::binary>>,
          size,
          next_largest(
            [<<first::utf8>> | String.graphemes(<<next::size(size)>>)],
            current_largest
          )
        )

      _ ->
        largest_prod(current_largest)
    end
  end

  defp next_largest(graphemes, current_largest),
    do:
      graphemes
      |> Enum.reduce(1, &(&1 |> String.to_integer() |> Kernel.*(&2)))
      |> max(current_largest)

  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1

  def largest_product(number_string, size) do
    if size < 1 || String.length(number_string) < size do
      raise ArgumentError
    end

    number_string
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.map(fn slice -> Enum.reduce(slice, &(&1 * &2)) end)
    |> Enum.max()
  end
end
