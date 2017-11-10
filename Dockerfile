FROM elixir:1.5
ENV PORT 4000
ENV MIX_ENV prod
ENV MIX_ARCHIVES=/.mix
ENV MIX_HOME=/.mix

WORKDIR /code

RUN mix local.hex --force \
    && mix local.rebar --force

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs

COPY mix.exs .
COPY mix.lock .

RUN mix deps.get
RUN mix deps.compile

COPY frontend/package.json frontend/package.json
COPY frontend/package-lock.json frontend/package-lock.json

RUN cd frontend && \
    npm install

COPY frontend frontend
RUN cd frontend && \
    npm run build:prod

COPY . .

RUN mix compile
RUN mix phx.digest

RUN useradd -m user
USER user

ENTRYPOINT ["mix"]
CMD ["phx.server"]
