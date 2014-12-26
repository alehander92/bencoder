defmodule Bencoder.Encode do
  @spec encode(term) :: String
  def encode(data) do
  	case Bencoder.Encoder.encode(data) do
  	  { encode } when encode |> is_binary ->
  	  	{ :ok, encode }

  	  %{__struct__: _} ->
  	  	{ :error, :recursive }

  	  value ->
  	    encode(value)
  	end
  end
end

defprotocol Bencoder.Encoder do
  @fallback_to_any true

  def encode(self)
end


defimpl Bencoder.Encoder, for: List do
  def encode([]) do
  	{ "le" }
  end

  def encode(self) do
  	[y | z] = Enum.map self, fn element ->
  	  Bencoder.Encode.encode(element)
  	end

  	["l", tl(y), z, "e"] |> IO.iodata_to_binary
  end
end

defimpl Bencoder.Encoder, for: Map do
  def encode(self) when map_size(self) == 0 do
  	{ "de" }
  end

  def encode(self) do
  	[y | z] = Enum.map self, fn { key, value } ->
  	  key = Bencoder.Encode.encode(to_string(key))
  	  value = Bencoder.Encode.encode(value)

  	  [name, value]
  	end

  	["d", tl(y), z, "e"] |> IO.iodata_to_binary
  end
end

defimpl Bencoder.Encoder, for: Atom do
  def encode(true) do
  	{ "1" }
  end

  def encode(false) do
  	{ "0" }
  end

  def encode(nil) do
  	{ "0" }
  end
end

defimpl Bencoder.Encoder, for: Integer do
  def encode(self) do
  	{ to_string(self) }
  end
end
