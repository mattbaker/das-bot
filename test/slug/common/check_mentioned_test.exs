defmodule Slug.Common.CheckMentionedTest do
  use ExUnit.Case
  doctest Slug.Common.CheckMentioned
  alias Slug.Common.CheckMentioned
  alias Slug.Event

  test "sets mentioned: true if bot is mentioned" do
    event =
      test_event("oh hi <@UTEST> !")
      |> CheckMentioned.call(:fake_bot)

    assert event.metadata.mentioned == true
  end

  test "sets mentioned: true if bot name is mentioned with an '@'" do
    event =
      test_event("oh hi @tester !")
      |> CheckMentioned.call(:fake_bot)

    assert event.metadata.mentioned == true
  end

  test "sets mentioned: false if bot is not mentioned" do
    event =
      test_event("oh hi")
      |> CheckMentioned.call(:fake_bot)

    assert event.metadata.mentioned == false
  end

  defp test_event(text) do
    %Event{
      bot_id: "UTEST",
      data: %{type: "message", text: text},
      metadata: %{bot_name: "tester"}
    }
  end
end
