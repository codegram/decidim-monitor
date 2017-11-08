FROM elixir:1.5.2-alpine

ENV MIX_ENV=prod

RUN apk add --update nodejs nodejs-npm

RUN adduser -D myuser

WORKDIR /home/myuser
RUN chown myuser:myuser /home/myuser

USER myuser

COPY --chown=myuser:myuser mix.exs /home/myuser/mix.exs
COPY --chown=myuser:myuser mix.lock /home/myuser/mix.lock

RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix deps.get
RUN mix deps.compile

COPY --chown=myuser:myuser frontend/package.json /home/myuser/frontend/package.json
COPY --chown=myuser:myuser frontend/package-lock.json /home/myuser/package-lock.json

RUN cd frontend && \
    npm install

COPY --chown=myuser:myuser . /home/myuser

RUN cd frontend && \
    npm run build:prod

RUN mix compile
RUN mix phx.digest

ENTRYPOINT ["mix"]
CMD ["phx.server"]
