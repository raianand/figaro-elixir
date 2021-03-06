defmodule FigaroElixir.Yaml do
  @config_path "config/application.yml"

  def load_file(path \\ @config_path) do
    file = config_file(path)
    cond do
      File.exists?(file) -> parse_file(file)
      true               -> raise "#{file} file not found"
    end
  end

  defp config_file(path), do: File.cwd! |> Path.join(path)

  defp parse_file(file_path) do
    file_path
      |> YamlExt.decode_file
      |> extract_map
    rescue
      FunctionClauseError -> %{}
  end

  defp extract_map(nil), do: %{}
  defp extract_map(map), do: map
end
