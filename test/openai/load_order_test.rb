# frozen_string_literal: true

require "open3"
require "rbconfig"

require_relative "test_helper"

class OpenAI::Test::LoadOrderTest < Minitest::Test
  def test_bundler_autorequires_openai_during_tapioca_dsl
    script = <<~RUBY
      module Tapioca
      end

      $PROGRAM_NAME = "tapioca"
      ARGV.replace(["dsl"])

      require "bundler/setup"
      Bundler.require(:default)

      raise "OpenAI::Client was not autorequired" unless defined?(OpenAI::Client)
    RUBY

    _, stderr, status =
      Open3.capture3(
        {"RUBYOPT" => nil},
        RbConfig.ruby,
        "-e",
        script,
        chdir: File.expand_path("../..", __dir__)
      )

    assert_predicate(status, :success?, stderr)
  end

  def test_loads_after_active_support_6_subclass_extensions
    script = <<~RUBY
      class Class
        def descendants
          ObjectSpace.each_object(singleton_class).reject do |candidate|
            candidate.singleton_class? || candidate == self
          end
        end

        def subclasses
          descendants.select { |candidate| candidate.superclass == self }
        end
      end

      require "openai"

      raise "missing OrHash" unless OpenAI::Models::Batch.sorbet_constant_defined?(:OrHash)
    RUBY

    _, stderr, status =
      Open3.capture3(
        RbConfig.ruby,
        "-I",
        File.expand_path("../../lib", __dir__),
        "-e",
        script
      )

    assert_predicate(status, :success?, stderr)
  end
end
