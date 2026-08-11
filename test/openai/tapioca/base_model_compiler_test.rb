# frozen_string_literal: true

require "open3"
require "rbconfig"

require_relative "../test_helper"

class OpenAI::Test::BaseModelCompilerTest < Minitest::Test
  ROOT = File.expand_path("../../..", __dir__)

  COMPILER_SCRIPT = <<~RUBY
    require "openai"

    module OpenAIBaseModelCompilerFixtures
      class Participant < OpenAI::BaseModel
        required :name, String
        required :nickname, String, nil?: true
      end

      class Event < OpenAI::BaseModel
        required :active, OpenAI::Boolean
        required :description, String, nil?: true
        required :participant, Participant
        required :participants, OpenAI::ArrayOf[Participant]
        required :aliases, OpenAI::ArrayOf[String, nil?: true]
        required :status, OpenAI::EnumOf[:confirmed, :tentative]
        required :detail, OpenAI::UnionOf[String, Participant]
      end
    end

    require "tapioca/helpers/test/dsl_compiler"
    abort("compiler is not discoverable") unless Gem.find_files(
      "tapioca/dsl/compilers/openai_base_model.rb"
    ).any?
    require "tapioca/dsl/compilers/openai_base_model"

    compiler = Tapioca::Dsl::Compilers::OpenAIBaseModel
    context = Tapioca::Helpers::Test::DslCompiler::CompilerContext.new(compiler)
    rbi = context.rbi_for("OpenAIBaseModelCompilerFixtures::Event")
    participant_rbi = context.rbi_for("OpenAIBaseModelCompilerFixtures::Participant")

    require "tmpdir"
    Dir.mktmpdir("openai-base-model-compiler-test") do |dir|
      rbi_path = File.join(dir, "event.rbi")
      participant_rbi_path = File.join(dir, "participant.rbi")
      usage_path = File.join(dir, "usage.rb")
      File.write(rbi_path, rbi)
      File.write(participant_rbi_path, participant_rbi)
      File.write(usage_path, <<~USAGE)
        # typed: true

        parsed = T.let(T.unsafe(nil), T.anything)
        event = T.cast(parsed, OpenAIBaseModelCompilerFixtures::Event)

        T.let(event.active, T::Boolean)
        T.let(event.description, T.nilable(String))
        T.let(event.participant, OpenAIBaseModelCompilerFixtures::Participant)
        T.let(
          event.participants,
          T::Array[OpenAIBaseModelCompilerFixtures::Participant]
        )
        T.let(event.aliases, T::Array[T.nilable(String)])
        T.let(event.status, Symbol)
        T.let(
          event.detail,
          T.any(OpenAIBaseModelCompilerFixtures::Participant, String)
        )
      USAGE

      runner = Object.new.extend(Tapioca::SorbetHelper)
      result = runner.sorbet(
        "--no-config",
        "--dir",
        "rbi",
        rbi_path,
        participant_rbi_path,
        usage_path
      )
      abort(result.err) unless result.status
    end

    puts(rbi)
  RUBY

  def test_loads_through_the_tapioca_cli
    stdout, stderr, status =
      Open3.capture3(
        {"RUBYOPT" => nil},
        RbConfig.ruby,
        Gem.bin_path("bundler", "bundle"),
        "exec",
        "tapioca",
        "dsl",
        "--list-compilers",
        "--only",
        "OpenAIBaseModel",
        chdir: ROOT
      )

    assert_predicate(status, :success?, stderr)
    assert_includes(stdout, "Tapioca::Dsl::Compilers::OpenAIBaseModel")
    refute_includes(stdout, "Cannot find compiler 'OpenAIBaseModel'")
  end

  def test_generates_typed_readers_for_structured_output_models
    stdout, stderr, status =
      Open3.capture3(
        {"RUBYOPT" => nil},
        RbConfig.ruby,
        "-I",
        File.join(ROOT, "lib"),
        "-e",
        COMPILER_SCRIPT,
        chdir: ROOT
      )

    assert_predicate(status, :success?, stderr)
    assert_includes(stdout, "class OpenAIBaseModelCompilerFixtures::Event")
    assert_includes(stdout, "sig { returns(T::Boolean) }\n  def active; end")
    assert_includes(stdout, "sig { returns(T.nilable(String)) }\n  def description; end")
    assert_includes(
      stdout,
      "sig { returns(OpenAIBaseModelCompilerFixtures::Participant) }\n  def participant; end"
    )
    assert_includes(
      stdout,
      <<~RBI.chomp
        sig { returns(T::Array[OpenAIBaseModelCompilerFixtures::Participant]) }
          def participants; end
      RBI
    )
    assert_includes(stdout, "sig { returns(T::Array[T.nilable(String)]) }\n  def aliases; end")
    assert_includes(stdout, "sig { returns(Symbol) }\n  def status; end")
    assert_includes(
      stdout,
      <<~RBI.chomp
        sig { returns(T.any(OpenAIBaseModelCompilerFixtures::Participant, String)) }
          def detail; end
      RBI
    )
  end
end
