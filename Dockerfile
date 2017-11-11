FROM elixir:1.5.2-alpine

ARG mix_env=prod

ENV PORT 4000
ENV MIX_ENV $mix_env
ENV MIX_ARCHIVES=/.mix
ENV MIX_HOME=/.mix

WORKDIR /code

RUN mix local.hex --force \
    && mix local.rebar --force

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

RUN if [ $MIX_ENV == "prod" ]; then cd frontend && npm run build:prod; fi

COPY . .

RUN mix compile
RUN if [ $MIX_ENV == "prod" ]; then mix phx.digest; fi

RUN apk add bash

RUN adduser -D user

RUN if [ $MIX_ENV == "dev" ]; then \
      chmod 777 . frontend priv/static priv && \
      chmod 777 -R priv/static _build \
    ; fi

USER user

ENTRYPOINT ["./docker-erlang-signals.sh"]
CMD ["phx.server"]
