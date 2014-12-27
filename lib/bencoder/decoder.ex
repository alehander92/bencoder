defmodule Bencoder.Decode do
  @spec decode(String) :: term
  def decode(data) do
    chars = String.to_char_list(data)
    {:ok, decoded, _} = decode_element(chars)
    decoded
  end

  defp decode_element(chars) do
    case hd(chars) do
      105 -> # i
        decode_integer(chars)
      108 -> # l
        decode_list(chars)
      100 -> # d
        decode_dictionary(chars)
      _ ->
        decode_string(chars)
    end
  end

  defp decode_integer(chars) do
    digits = Enum.take_while(tl(chars), fn (x) -> x != 101 end) # e
    {number, _} = ('0' ++ digits) |> to_string |> Integer.parse
    {:ok, number, Enum.drop(chars, 2 + length(digits))}
  end

  defp decode_list(chars) do
    decode_list_elements(tl(chars), [])
  end

  defp decode_list_elements(chars, z) do
    case hd(chars) do
      101 ->
        {:ok, z, tl(chars)}
      _ ->
        {:ok, decoded, remaining} = decode_element(chars)
        decode_list_elements(remaining, z ++ [decoded])
    end
  end

  defp decode_dictionary(chars) do
    decode_dictionary_elements(tl(chars), %{})
  end

  defp decode_dictionary_elements(chars, map) do
    case hd(chars) do
      101 ->
        {:ok, map, tl(chars)}
      _ ->
        {:ok, decoded_key, remaining} = decode_element(chars)
        {:ok, decoded_value, remaining} = decode_element(remaining)
        decode_dictionary_elements(remaining, Map.put(map, decoded_key, decoded_value))
    end
  end

  defp decode_string(chars) do
    digits = Enum.take_while(chars, fn (x) -> x != 58 end)
    {s, _} = digits |> to_string |> Integer.parse
    word = Enum.drop(chars, length(digits) + 1)
    {:ok, to_string(Enum.take(word, s)), Enum.drop(word, s)}
  end
end
