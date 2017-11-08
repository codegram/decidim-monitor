FROM elixir:1.5.2-alpine

ENV MIX_ENV=prod

RUN apk add --update nodejs nodejs-npm

RUN adduser -D myuser

WORKDIR /home/myuser

USER myuser

COPY mix.exs /home/myuser/mix.exs
COPY mix.lock /home/myuser/mix.lock

RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix deps.get
RUN mix deps.compile

COPY frontend/package.json /home/myuser/frontend/package.json
COPY frontend/package-lock.json /home/myuser/package-lock.json

RUN cd frontend && \
    npm install

COPY . /home/myuser

RUN cd frontend && \
    npm run build:prod

RUN mix compile
RUN mix phx.digest

ENTRYPOINT ["mix"]
CMD ["phx.server"]
