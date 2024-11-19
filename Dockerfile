# Build stage
FROM hexpm/elixir:1.17.3-erlang-25.2.3-ubuntu-noble-20241015 as builder

# Install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Prepare build dir
WORKDIR /app

# Install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Set mix env to prod
ENV MIX_ENV=prod

# Install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

# Copy all application files
COPY . .

# Compile the application
RUN mix compile

# Build the release
RUN mix release

# ... existing code ...

# Release stage
FROM ubuntu:noble-20241015

# Install runtime dependencies
RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncursesw6 locales \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

# ... rest of the file remains the same ...

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR /app

# Copy the release from the builder stage
COPY --from=builder /app/_build/prod/rel/todo_api ./

# Set the environment variables
ENV HOME=/app
ENV PORT=4000

# Expose the port
EXPOSE 4000

CMD ["bin/todo_api", "start"]