FROM elixir:1.12.2-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base git python3 libstdc++

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

COPY priv priv
RUN mix phx.digest

# compile and build release
COPY lib lib
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix do compile, release

CMD ["_build/prod/rel/fourletters/bin/fourletters", "start"]
