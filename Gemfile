# frozen_string_literal: true

source "https://rubygems.org", cooldown: 7

gemspec

group :development do
  gem "rake"
  gem "rbs"
  gem "rubocop"
  gem "sorbet"
  gem "steep"
  gem "syntax_tree"
  gem "syntax_tree-rbs", github: "ruby-syntax-tree/syntax_tree-rbs", branch: "main"
end

group :development, :test do
  gem "async"
  gem "async-websocket"
  gem "aws-sdk-core", "~> 3"
  gem "minitest", "~> 5.27"
  gem "minitest-hooks"
  gem "minitest-proveit"
  gem "sorbet-runtime"
  gem "webmock"
end

group :development, :docs do
  gem "redcarpet"
  gem "webrick"
  gem "yard"
end
