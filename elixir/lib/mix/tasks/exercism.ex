defmodule Mix.Tasks.Exercism do
  @win_cmd "cmd.exe"

  @spec run([String.t(), ...]) :: :ok
  def run(args), do: task(args)

  defp task(["test", path]) do
    ext = Path.extname(path)

    cond do
      not valid_elixir_file?(ext) ->
        raise "File must be a '.ex' or '.exs' file"

      true ->
        root = Path.rootname(path)

        cond do
          String.ends_with?(root, "test") ->
            run_cmd("mix", ["test", path])

          ext == ".exs" ->
            run_cmd("mix", ["test", "#{root}_test.exs"])

          ext == ".ex" ->
            File.write!(root <> ".exs", File.read!(path))
            run_cmd("mix", ["test", "#{root}_test.exs"])
        end
    end
  end

  defp task(["submit", path]) do
    ext = Path.extname(path)

    cond do
      not valid_elixir_file?(ext) ->
        raise "File must be a '.ex' or '.exs' file"

      true ->
        root =
          path
          |> Path.rootname()
          |> String.replace("_test", "")

        exs_path = "#{root}.exs"
        File.write!(exs_path, File.read!(root <> ".ex"))

        run_cmd(
          "exercism",
          ["submit", exs_path]
        )
    end
  end

  defp task(["exs-to-ex", path]) do
    ext = Path.extname(path)

    cond do
      ext != ".exs" ->
        raise "File must be a '.exs' file"

      true ->
        File.write!(Path.rootname(path) <> ".ex", File.read!(path))
    end
  end

  defp valid_elixir_file?(ext), do: Enum.member?([".ex", ".exs"], ext)

  defp run_cmd(command, args), do: run_cmd(command, args, [])

  defp run_cmd(command, args, opts) do
    {os_family, _} = :os.type()

    {command, args} =
      case Atom.to_string(os_family) =~ "win" do
        true ->
          args = ["/c", command | args]
          command = @win_cmd
          {command, args}

        _ ->
          {command, args}
      end

    {cmd, _status} = System.cmd(command, args, opts)

    Mix.shell().info(cmd)
  end
end
