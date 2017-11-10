FROM elixir:1.5.2-alpine

ENV MIX_ENV=prod
ENV PORT=4000
EXPOSE 4000

RUN apk add --update nodejs nodejs-npm

RUN adduser -D myuser

RUN mkdir /home/myuser/code
WORKDIR /home/myuser/code

COPY mix.exs mix.exs
COPY mix.lock mix.lock
RUN chown myuser -R /home/myuser/code

USER myuser
RUN mix local.hex --force
RUN mix local.rebar --force

RUN mix deps.get
RUN mix deps.compile

USER root
COPY frontend/package.json frontend/package.json
COPY frontend/package-lock.json frontend/package-lock.json
RUN chown myuser -R .
USER myuser

RUN cd frontend && \
    npm install

USER root
COPY frontend frontend
RUN chown myuser -R frontend
USER myuser

RUN cd frontend && \
    npm run build:prod

USER root
COPY . .
RUN chown myuser -R .
USER myuser

RUN mix compile
RUN mix phx.digest

ENTRYPOINT ["mix"]
CMD ["phx.server"]
