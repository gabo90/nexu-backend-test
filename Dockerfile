FROM ruby:3.0.5-slim-bullseye as builder

# Clean and update system package manager
RUN apt-get clean
RUN apt-get update -qq
# Install system dependencies
RUN apt-get install -y --no-install-recommends tzdata libpq-dev build-essential

WORKDIR /app

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install --jobs 5 --retry 5


FROM ruby:3.0.5-slim-bullseye

# Clean and update system package manager
RUN apt-get clean
RUN apt-get update -qq
# install missing pg gem dependencies
RUN apt-get install -y --no-install-recommends libpq-dev

ENV RAILS_LOG_TO_STDOUT true

WORKDIR /app
COPY . .

COPY --from=builder /usr/local/bundle /usr/local/bundle

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "/app/config/puma.rb"]
