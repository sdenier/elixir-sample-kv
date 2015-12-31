defmodule KV.Bucket do

    def start_link() do
        Agent.start_link fn -> %{} end
    end

    def get(bucket, key) do
        Agent.get(bucket, fn map -> map[key] end)
    end

    def put(bucket, key, value) do
       Agent.update(bucket, fn map -> Dict.put(map, key, value) end) 
    end

end
