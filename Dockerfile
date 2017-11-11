FROM elixir:1.5.2-alpine

ENV PORT 4000
ENV MIX_ENV prod
ENV MIX_ARCHIVES=/.mix
ENV MIX_HOME=/.mix

WORKDIR /code

RUN mix local.hex --force \
    && mix local.rebar --force

RUN apk add --update bash
RUN apk add --update nodejs nodejs-npm
RUN apk add --update inotify-tools

COPY mix.exs .
COPY mix.lock .

RUN mix deps.get
RUN mix deps.compile

COPY frontend/package.json frontend/package.json
COPY frontend/package-lock.json frontend/package-lock.json

RUN cd frontend && \
    npm install

COPY frontend frontend

RUN cd frontend && npm run build:prod

COPY . .

RUN mix compile
RUN mix phx.digest

RUN adduser -D user

USER user

ENTRYPOINT ["./docker-erlang-signals.sh"]
CMD ["phx.server"]
