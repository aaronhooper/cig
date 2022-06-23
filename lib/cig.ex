defmodule Cig do

  def main(argv) do
    argv
    |> parse
    |> format_url
    |> fetch
    |> handle_response
    |> IO.write
  end

  def parse([arg | _]), do: arg

  def format_url(arg) do
    url = "https://raw.githubusercontent.com/github/gitignore/main/#{arg}.gitignore"
    {url, arg}
  end

  def fetch({url, arg}), do: {HTTPoison.get!(url), arg}

  def handle_response({%HTTPoison.Response{body: body, status_code: 200}, _}), do: body
  def handle_response({%HTTPoison.Response{status_code: 404}, arg}) do
    """
    #{arg}.gitignore not found.
    Visit https://github.com/github/gitignore for available templates.
    """
  end
end
