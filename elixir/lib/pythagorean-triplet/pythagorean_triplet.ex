defmodule Triplet do
  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet), do: Enum.sum(triplet)

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product([a, b, c]), do: a * b * c

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]), do: a * a + b * b == c * c

  @doc """
  Generates a list of pythagorean triplets from a given min (or 1 if no min) to a given max.
  """
  @spec generate(non_neg_integer, non_neg_integer | nil) :: [list(non_neg_integer)]
  def generate(min, max \\ nil) do
    {min, max} = if max == nil, do: {1, min}, else: {min, max}

    min..max
    |> Enum.flat_map(fn a ->
      (a + 1)..max
      |> Enum.flat_map(fn b ->
        (b + 1)..max
        |> Enum.reduce([], fn c, acc ->
          triplet = [a, b, c]
          if pythagorean?(triplet), do: [triplet | acc], else: acc
        end)
      end)
    end)
  end

  @doc """
  Generates a list of pythagorean triplets from a given min to a given max, whose values add up to a given sum.
  """
  @spec generate(non_neg_integer, non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max, sum),
    do:
      min
      |> generate(max)
      |> Enum.filter(&(sum(&1) == sum))
end
