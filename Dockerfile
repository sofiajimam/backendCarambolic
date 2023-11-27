FROM ruby:3.2.1

ENV RAILS_ROOT=/var/www/app
SHELL ["/bin/bash", "-c"]

RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY . .

ARG PORT
ARG RAILS_ENV
ARG RAILS_MASTER_KEY
ARG REDIS_URL
ARG SECRET_KEY_BASE
ARG OPENAI_ORGANIZATION_ID
ARG OPENAI_ACCESS_TOKEN

ARG DATABASE_URL
ARG PGDATABASE
ARG PGUSER
ARG PGPASSWORD
ARG PGHOST
ARG PGPORT    

ENV DATABASE_URL=$DATABASE_URL
ENV PGDATABASE=$PGDATABASE
ENV PGUSER=$PGUSER
ENV PGPASSWORD=$PGPASSWORD
ENV PGHOST=$PGHOST
ENV PGPORT=$PGPORT

ENV RAILS_ENV=$RAILS_ENV
ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE
ENV REDIS_URL=$REDIS_URL
ENV OPENAI_ORGANIZATION_ID=$OPENAI_ORGANIZATION_ID
ENV OPENAI_ACCESS_TOKEN=$OPENAI_ACCESS_TOKEN
ENV PORT=$PORT

RUN gem install bundler && bundle install --jobs 20 --retry 5

EXPOSE 3000

CMD rails db:setup ; rails db:migrate ; rails server -b 0.0.0.0 -p $PORT

