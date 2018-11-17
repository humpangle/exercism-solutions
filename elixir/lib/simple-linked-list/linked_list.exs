defmodule LinkedList do
  @opaque t :: {term, term}

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: {nil, nil}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    {hd, tl} = list
    {elem, {hd, tl}}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list), do: length(list, 0)

  @spec length(t, non_neg_integer()) :: non_neg_integer()
  def length({nil, nil}, acc), do: acc
  def length({_hd, tl}, acc), do: length(tl, acc + 1)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({nil, nil}), do: true
  def empty?(_list), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({nil, nil}), do: {:error, :empty_list}
  def peek({h, _tl}), do: {:ok, h}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({nil, nil}), do: {:error, :empty_list}
  def tail({_h, t}), do: {:ok, t}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({nil, nil}), do: {:error, :empty_list}
  def pop({h, t}), do: {:ok, h, t}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list),
    do: list |> Enum.reduce(new(), &push(&2, &1))

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list), do: to_list(list, [])

  @spec to_list(list :: t, acc :: List.t()) :: List.t()
  def to_list({nil, nil}, acc), do: acc
  def to_list({h, t}, acc), do: to_list(t, [h | acc])

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: reverse(list, new())
  def reverse({nil, nil}, acc), do: acc
  def reverse({h, t}, acc), do: reverse(t, push(acc, h))
end
