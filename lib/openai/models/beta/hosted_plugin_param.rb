# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class HostedPluginParam < OpenAI::Internal::Type::BaseModel
        # @!attribute description
        #   The plugin description declared in `.codex-plugin/plugin.json`.
        #
        #   @return [String]
        required :description, String

        # @!attribute name
        #   The plugin name declared in `.codex-plugin/plugin.json`.
        #
        #   @return [String]
        required :name, String

        # @!attribute source
        #   Provides ZIP bytes encoded with standard base64.
        #
        #   @return [OpenAI::Models::Beta::InlineCapabilitySourceParam]
        required :source, -> { OpenAI::Beta::InlineCapabilitySourceParam }

        # @!attribute type
        #   The type of the object. Always `inline`.
        #
        #   @return [Symbol, :inline]
        required :type, const: :inline

        # @!method initialize(description:, name:, source:, type: :inline)
        #   Supplies a plugin ZIP directly in the session request.
        #
        #   @param description [String]
        #     The plugin description declared in `.codex-plugin/plugin.json`.
        #
        #   @param name [String]
        #     The plugin name declared in `.codex-plugin/plugin.json`.
        #
        #   @param source [OpenAI::Models::Beta::InlineCapabilitySourceParam]
        #     Provides ZIP bytes encoded with standard base64.
        #
        #   @param type [Symbol, :inline]
        #     The type of the object. Always `inline`.
      end
    end
  end
end
