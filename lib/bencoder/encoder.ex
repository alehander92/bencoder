defmodule Bencoder.Encode do
  @spec encode(term) :: String
  def encode(data) do
    Bencoder.Encoder.encode(data)
  end
end

defprotocol Bencoder.Encoder do
  @fallback_to_any true

  def encode(self)
end


defimpl Bencoder.Encoder, for: List do
  def encode([]) do
    "le"
  end

  def encode(self) do
    [y | z] = Enum.map self, fn element ->
      Bencoder.Encode.encode(element)
    end

    ["l", y, z, "e"] |> IO.chardata_to_string
  end
end

defimpl Bencoder.Encoder, for: Map do
  def encode(self) when map_size(self) == 0 do
    "de"
  end

  def encode(self) do
    [y | z] = Enum.map self, fn { key, value } ->
      key = Bencoder.Encode.encode(to_string(key))
      value = Bencoder.Encode.encode(value)

      [key, value]
    end
    ["d", y, z, "e"] |> IO.chardata_to_string
  end
end

defimpl Bencoder.Encoder, for: Atom do
  def encode(true) do
    "1"
  end

  def encode(false) do
    "0"
  end

  def encode(nil) do
    "0"
  end
end

defimpl Bencoder.Encoder, for: Integer do
  def encode(self) do
    ["i", to_string(self), "e"] |> IO.chardata_to_string
  end
end

defimpl Bencoder.Encoder, for: BitString do
  def encode(self) do
    [to_string(String.length self), ":", self] |> IO.chardata_to_string
  end
end


