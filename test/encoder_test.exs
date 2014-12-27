Code.require_file "test_helper.exs", __DIR__

defmodule EncoderTest do
  use ExUnit.Case, async: true

  test "encodes numbers correctly" do
    assert Bencoder.encode(0)    == "i0e"
    assert Bencoder.encode(94)   == "i94e"
  end

  test "encodes strings correctly" do
    assert Bencoder.encode("")  == "0:"
    assert Bencoder.encode("æß")    == "2:æß"
  end

  test "encodes maps correctly" do
    assert Bencoder.encode(%{})        == "de"
    assert Bencoder.encode(%{"e" => 2})== "d1:ei2ee"
  end

  test "encodes arrays correctly" do
    assert Bencoder.encode([%{"e" => "zz"}, 4]) == "ld1:e2:zzei4ee"
    assert Bencoder.encode([])                  == "le"
  end
end
