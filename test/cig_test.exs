defmodule CigTest do
  use ExUnit.Case
  doctest Cig

  test "greets the world" do
    assert Cig.hello() == :world
  end
end
