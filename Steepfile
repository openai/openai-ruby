# frozen_string_literal: true

require "yaml"

target(:lib) do
  configure_code_diagnostics(Steep::Diagnostic::Ruby.strict)

  signature("sig")

  YAML.safe_load_file("./manifest.yaml", symbolize_names: true) => {dependencies:}
  # The runtime require name is `net/http`; RBS publishes it as `net-http`.
  library("net-http")
  # currently these libraries lack the `*.rbs` annotations required by `steep`
  stdlibs = dependencies - %w[English etc net/http rbconfig set stringio]

  stdlibs.each { library(_1) }
end
