# frozen_string_literal: true

source "https://rubygems.org", cooldown: 7

gemspec

group :development do
  gem "rake"
  gem "rbs"
  gem "rubocop"
  # Later Sorbet requires T::Module, which older customer typecheckers cannot parse.
  gem "sorbet", "< 0.6.13426"
  gem "steep"
  gem "syntax_tree"
  gem "syntax_tree-rbs", github: "ruby-syntax-tree/syntax_tree-rbs", branch: "main"
end

group :development, :test do
  gem "async"
  gem "async-websocket"
  gem "cgi"
  gem "minitest", "~> 6.0"
  gem "minitest-hooks", ">= 1.5.4"
  gem "minitest-mock", "~> 5.27"
  gem "minitest-proveit"
  gem "sorbet-runtime"
  gem "webmock"
end
