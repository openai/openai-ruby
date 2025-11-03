# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :development do
  gem "rake"
  gem "rbs"
  gem "rubocop"
  gem "sorbet"
  gem "steep"
  gem "syntax_tree"
  gem "syntax_tree-rbs", github: "ruby-syntax-tree/syntax_tree-rbs", branch: "main"
  gem "tapioca"
end

group :development, :test do
  gem "async"
  gem "minitest"
  gem "minitest-focus"
  gem "minitest-hooks"
  gem "minitest-proveit"
  gem "minitest-rg"
  gem "webmock"
end

group :development, :docs do
  gem "redcarpet"
  gem "webrick"
  gem "yard"
end
