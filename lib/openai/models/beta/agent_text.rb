# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentText < OpenAI::Internal::Type::BaseModel
        # @!attribute format_
        #   The effective output format. Defaults to ordinary text.
        #
        #   @return [OpenAI::Models::Beta::TextFormat::Text, OpenAI::Models::Beta::TextFormat::JSONSchema]
        required :format_, union: -> { OpenAI::Beta::TextFormat }, api_name: :format

        # @!attribute verbosity
        #   The amount of text produced by the agent. Defaults to `medium`.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentText::Verbosity]
        required :verbosity, enum: -> { OpenAI::Beta::AgentText::Verbosity }

        # @!method initialize(format_:, verbosity:)
        #   The text configuration used by an agent.
        #
        #   @param format_ [OpenAI::Models::Beta::TextFormat::Text, OpenAI::Models::Beta::TextFormat::JSONSchema]
        #     The effective output format. Defaults to ordinary text.
        #
        #   @param verbosity [Symbol, OpenAI::Models::Beta::AgentText::Verbosity]
        #     The amount of text produced by the agent. Defaults to `medium`.

        # The amount of text produced by the agent. Defaults to `medium`.
        #
        # @see OpenAI::Models::Beta::AgentText#verbosity
        module Verbosity
          extend OpenAI::Internal::Type::Enum

          LOW = :low
          MEDIUM = :medium
          HIGH = :high

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
