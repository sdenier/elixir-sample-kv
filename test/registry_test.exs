defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  setup context do
    {:ok, registry} = KV.Registry.start_link(context.test)
    {:ok, registry: registry}
  end

  test "spawns bucket", %{registry: registry} do
    assert KV.Registry.lookup(registry, "shopping") == :error

    assert KV.Registry.create(registry, "shopping")
    {:ok, shopping} = KV.Registry.lookup(registry, "shopping")

    KV.Bucket.put(shopping, "milk", 1)
    assert KV.Bucket.get(shopping, "milk") == 1
  end

  test "removes buckets on exit", %{registry: registry} do
    KV.Registry.create(registry, "shopping")
    {:ok, bucket} = KV.Registry.lookup(registry, "shopping")

    Agent.stop(bucket)
    assert KV.Registry.lookup(registry, "shopping") == :error
  end

end
