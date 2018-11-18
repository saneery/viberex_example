# ViberexExample

**This project is example of working with [Viberex](https://github.com/saneery/viberex)**

## Getting Started

Set Viber token at `config/config.exs`:

```elixir
config :viberex,
  auth_token: "your_token"
```

Run application inside IEx:

```bash
$ iex -S mix
```

Set webhook:

```elixir
Viberex.ser_webhook("https://your_url")
```