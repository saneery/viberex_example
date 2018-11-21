defmodule ViberexExample.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(ViberexExample.Server, ["viber/webhook", 4000]),
    ]

    opts = [strategy: :one_for_one, name: ViberexExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
