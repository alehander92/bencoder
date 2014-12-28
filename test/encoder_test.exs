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

  test "encodes nested maps correctly" do
    assert Bencoder.encode(%{"e" => []}) == "d1:elee"
    assert Bencoder.encode(%{2 => %{"x" => [[]]}}) == "d1:2d1:xlleeee"
  end

  test "encodes binaries correctly" do
    assert Bencoder.encode(<<>>) == "0:"
    # assert Bencoder.encode(<<206, 165, 217, 80, 25, 72, 126, 48, 166, 224, 100, 245, 122, 33, 97, 203, 45, 207, 60, 199, 120, 97, 33, 217, 27, 248, 14, 70, 133, 76, 193, 116, 163, 151, 195, 204, 165, 80, 251, 85, 36, 130, 123, 35>>) ==
    #                        <<?4, ?4, ?:, 206, 165, 217, 80, 25, 72, 126, 48, 166, 224, 100, 245, 122, 33, 97, 203, 45, 207, 60, 199, 120, 97, 33, 217, 27, 248, 14, 70, 133, 76, 193, 116, 163, 151, 195, 204, 165, 80, 251, 85, 36, 130, 123, 35>>
  end
end
