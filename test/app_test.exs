defmodule Tentacat.AppTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.App

  doctest Tentacat.App

  @client Tentacat.Client.new(%{jwt: "your.jwt.here"})

  setup_all do
    Application.put_env :tentacat, :extra_headers, [{"Accept", "application/vnd.github.machine-man-preview+json"}]
    ExVCR.Config.filter_request_headers "Authorization"
    HTTPoison.start
  end

  test "me/1" do
    use_cassette "app#me" do
      assert me(@client)["name"] == "tentacatty"
    end
  end
end
