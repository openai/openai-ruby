# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentText < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentText,
            OpenAI::Internal::AnyHash
          )
        end

        # The effective output format. Defaults to ordinary text.
        sig { returns(OpenAI::Beta::TextFormat::Variants) }
        attr_accessor :format_

        # The amount of text produced by the agent. Defaults to `medium`.
        sig { returns(OpenAI::Beta::AgentText::Verbosity::TaggedSymbol) }
        attr_accessor :verbosity

        # The text configuration used by an agent.
        sig do
          params(

            format_: T.any(OpenAI::Beta::TextFormat::Text::OrHash, OpenAI::Beta::TextFormat::JSONSchema::OrHash),

            verbosity: OpenAI::Beta::AgentText::Verbosity::OrSymbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The effective output format. Defaults to ordinary text.
          format_:,

          # The amount of text produced by the agent. Defaults to `medium`.

          verbosity:
        )
        end

        sig do
          override.returns(
            {format_: OpenAI::Beta::TextFormat::Variants, verbosity: OpenAI::Beta::AgentText::Verbosity::TaggedSymbol}
          )
        end
        def to_hash
        end

        # The amount of text produced by the agent. Defaults to `medium`.
        module Verbosity
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentText::Verbosity) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LOW = T.let(:low, OpenAI::Beta::AgentText::Verbosity::TaggedSymbol)
          MEDIUM = T.let(:medium, OpenAI::Beta::AgentText::Verbosity::TaggedSymbol)
          HIGH = T.let(:high, OpenAI::Beta::AgentText::Verbosity::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentText::Verbosity::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
