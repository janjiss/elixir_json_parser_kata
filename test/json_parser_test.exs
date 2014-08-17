defmodule JsonParserTest do
  use ExUnit.Case

  test "json parsing with simple values" do
    assert(JsonParser.parse("{\"hello\": \"world\"}") == %{"hello" => "world"})
  end

  test "json parsing with more complex example" do
    json_example = """
    {
      "key": "value",
      "nested": {
        "nested_key": "nested_value",
        "one_more_nested_key": "nested_value",
        "one_more_nested": {
          "nested_key": "nested_value"
        }
      },
      "one_more_nested": {
        "nested_key": "nested_value"
      }
    }
    """
    assert(JsonParser.parse(json_example) == 
    %{
        "key" => "value",
        "nested" => %{
          "nested_key" => "nested_value",
          "one_more_nested_key" => "nested_value",
          "one_more_nested" => %{
            "nested_key" => "nested_value"
          }
        },
        "one_more_nested" => %{
          "nested_key" => "nested_value"
        }
    })
  end
end
