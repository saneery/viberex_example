defmodule ViberexExampleTest do
  use ExUnit.Case
  doctest ViberexExample

  test "greets the world" do
    assert ViberexExample.hello() == :world
  end
end
