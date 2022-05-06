# This Dockerfile is based upon https://hub.docker.com/_/ruby/
# Simply runs the FizzBuzz specs (tests)

FROM ruby:3.1.2

# Throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir /ruby31-practice
WORKDIR /ruby31-practice

# Install the Ruby dependencies (defined in the Gemfile/Gemfile.lock)
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Populate the Docker Working Directory with the FizzBuzz project (code)
COPY . .

# Run the tests
# CMD rspec
