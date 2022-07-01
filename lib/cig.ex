defmodule Cig do

  def main(argv) do
    argv
    |> parse
    |> format_url
    |> fetch
    |> handle_response
    |> IO.write
  end

  def parse([language | _]), do: language

  def format_url(language) do
    url = "https://raw.githubusercontent.com/github/gitignore/main/#{language}.gitignore"
    {url, language}
  end

  def fetch({url, language}), do: {HTTPoison.get!(url), language}

  def handle_response({%HTTPoison.Response{body: body, status_code: 200}, _}), do: body
  def handle_response({%HTTPoison.Response{status_code: 404}, language}) do
    """
    #{language}.gitignore not found.
    Visit https://github.com/github/gitignore for available templates.
    """
  end
end
