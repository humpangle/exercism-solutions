defmodule Mix.Tasks.Exercism do
  @spec run([String.t(), ...]) :: :ok
  def run(args), do: task(args)

  defp task(["ex_to_exs", path]) do
    cond do
      not File.exists?(path) ->
        raise "I can not find the given file: '#{path}'"

      Path.extname(path) != ".ex" ->
        raise "File must be a '.ex' file"

      true ->
        File.write!(Path.rootname(path) <> ".exs", File.read!(path))
    end
  end
end
