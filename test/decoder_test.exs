Code.require_file "test_helper.exs", __DIR__

defmodule DecoderTest do
  use ExUnit.Case, async: True

  test "decodes numbers correctly" do
    assert Bencoder.decode("i0e")  == 0
  end

  test "decodes strings correctly" do
    assert Bencoder.decode("0:")     == ""
    assert Bencoder.decode("3:0я")   == "0я"
    assert Bencoder.decode("4:like") == "like"
    assert Bencoder.decode("11:Çxa!Ù я`") == "Çxa!Ù я`"

  end

  test "decodes dictionaries correctly" do
    assert Bencoder.decode("d4:love6:sophiae") == %{"love" => "sophia"}
    assert Bencoder.decode("de")               == %{}
  end

  test "decodes lists correctly" do
    assert Bencoder.decode("li1992eli0ee2:48e")  == [1992, [0], "48"]
    assert Bencoder.decode("le")                 == []
  end
end
