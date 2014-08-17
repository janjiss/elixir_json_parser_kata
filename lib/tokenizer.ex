defmodule Tokenizer do
  def tokenize(content) do
    String.split(content, "") |>
    Enum.reduce([], fn (character, acc) -> 
      tokenize(acc, character)
    end) |>
    Enum.reverse
  end

  defp tokenize(acc, "{") do
    [:object_start] ++ acc
  end

  defp tokenize(acc, "\"") do
    case acc do
      [%StringToken{content: _} | _] -> 
        acc
      acc ->
        [%StringToken{}] ++ acc
    end
  end

  defp tokenize(acc, ",") do
    [:comma_seperator] ++ acc
  end

  defp tokenize(acc, ":") do
    [:key_value_seperator] ++ acc
  end

  defp tokenize(acc, "}") do
    [:object_end] ++ acc
  end

  defp tokenize(acc, " ") do
    acc
  end

  defp tokenize(acc, "\n") do
    acc
  end

  defp tokenize(acc, "") do
    acc
  end


  defp tokenize(acc, string_char) do
    case acc do
      [%StringToken{content: content} | _] -> 
        [_ | tail] = acc
        [%StringToken{content: content <> string_char }] ++ tail
    end
  end
end
