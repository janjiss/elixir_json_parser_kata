defmodule JsonParser do
  def parse(json_string) do
    json_string |>
    Tokenizer.tokenize |>
    parse_tokens
  end

  def parse_tokens(tokens) do
    parse_tokens(tokens, %{})
  end

  def parse_tokens([:object_start | tail], %{}) do
    parse_tokens(tail, %{})
  end

  def parse_tokens([:comma_seperator | tail], acc) do
    parse_tokens(tail, acc)
  end

  def parse_tokens([:object_end], acc) do
    acc
  end

  def parse_tokens([:object_end | tail], acc) do
    {tail, acc}
  end

  def parse_tokens([%StringToken{content: key}, :key_value_seperator, :object_start | tail], acc) do
    {new_tail, acc_value} = parse_tokens(tail)
    parse_tokens(new_tail, Map.put(acc, key, acc_value))
  end

  def parse_tokens([%StringToken{content: key}, :key_value_seperator , %StringToken{content: value} | tail], acc) do
    parse_tokens(tail, Map.put(acc, key, value))
  end
end
