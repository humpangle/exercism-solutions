Benchee.run(%{
  "Recursion" => fn -> Triplet.generate(1, 1_000) end,
  "Enum reduce" => fn -> Triplet.permutation1(1, 1_000) end,
  "Stream flat map" => fn -> Triplet.permutation_stream_flat_map(1, 1_000) end
})
