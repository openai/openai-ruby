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

      def self.assert_reader_contract(event, source:, detail_type: Participant)
        checks = {
          active: [true, false].include?(event.active),
          description: event.description.nil? || event.description.is_a?(String),
          participant: event.participant.is_a?(Participant),
          participants: event.participants.all?(Participant),
          aliases: event.aliases.all? { _1.nil? || _1.is_a?(String) },
          status: event.status.is_a?(Symbol),
          detail: event.detail.is_a?(detail_type)
        }

        checks.each do |field, matches|
          abort([source, field, "reader disagrees with its generated RBI"].join(": ")) unless matches
        end
      end

      def self.assert_raw_values(event, values, source:)
        values.each do |field, raw|
          next if event[field].equal?(raw) && event.to_h.fetch(field).equal?(raw)

          abort([source, field, "raw caller-owned value was replaced"].join(": "))
        end
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

    participant = {name: "Ada", nickname: nil}
    participants = [{name: "Grace", nickname: nil}]
    aliases = [:lead, nil]
    status = "confirmed"
    detail = {name: "Margaret", nickname: nil}
    payload = {
      active: true,
      description: "scheduled",
      participant: participant,
      participants: participants,
      aliases: aliases,
      status: status,
      detail: detail
    }
    constructed = OpenAIBaseModelCompilerFixtures::Event.new(payload)
    OpenAIBaseModelCompilerFixtures.assert_reader_contract(constructed, source: "constructor")
    OpenAIBaseModelCompilerFixtures.assert_raw_values(
      constructed,
      payload.slice(:participant, :participants, :aliases, :status, :detail),
      source: "constructor"
    )

    replacement = {name: "Katherine", nickname: nil}
    replacement_participants = [{name: "Joan", nickname: nil}]
    replacement_aliases = [:reviewer, nil]
    replacement_status = "tentative"
    replacement_detail = {name: "Dorothy", nickname: nil}
    assigned = OpenAIBaseModelCompilerFixtures::Event.new
    assigned.active = false
    assigned.description = "updated"
    assigned.participant = replacement
    assigned.participants = replacement_participants
    assigned.aliases = replacement_aliases
    assigned.status = replacement_status
    assigned.detail = replacement_detail
    OpenAIBaseModelCompilerFixtures.assert_reader_contract(assigned, source: "assignment")
    OpenAIBaseModelCompilerFixtures.assert_raw_values(
      assigned,
      {
        participant: replacement,
        participants: replacement_participants,
        aliases: replacement_aliases,
        status: replacement_status,
        detail: replacement_detail
      },
      source: "assignment"
    )

    assigned.detail = "speaker"
    OpenAIBaseModelCompilerFixtures.assert_reader_contract(
      assigned,
      source: "scalar union assignment",
      detail_type: String
    )

    state = OpenAI::Internal::Type::Converter.new_coerce_state
    parsed = OpenAI::Internal::Type::Converter.coerce(
      OpenAIBaseModelCompilerFixtures::Event,
      payload.merge(description: nil),
      state: state
    )
    abort("parsed response reported a conversion error") unless state.fetch(:error).nil?
    OpenAIBaseModelCompilerFixtures.assert_reader_contract(parsed, source: "parsed response")
    {
      participant: parsed.participant,
      participants: parsed.participants,
      detail: parsed.detail
    }.each do |field, materialized|
      abort(["parsed response", field, "materialized value was replaced"].join(": ")) unless (
        parsed[field].equal?(materialized)
      )
    end

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

        constructed = OpenAIBaseModelCompilerFixtures::Event.new
        T.let(constructed.participant, OpenAIBaseModelCompilerFixtures::Participant)
        T.let(
          constructed.participants,
          T::Array[OpenAIBaseModelCompilerFixtures::Participant]
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
