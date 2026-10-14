# typed: strong

module OpenAI
  module Models

    module Beta

      class HostedPluginParam < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::HostedPluginParam,
            OpenAI::Internal::AnyHash
          )
        end

        # The plugin description declared in `.codex-plugin/plugin.json`.
        sig { returns(String) }
        attr_accessor :description

        # The plugin name declared in `.codex-plugin/plugin.json`.
        sig { returns(String) }
        attr_accessor :name

        # Provides ZIP bytes encoded with standard base64.
        sig { returns(OpenAI::Beta::InlineCapabilitySourceParam) }
        attr_reader :source

        sig { params(source: OpenAI::Beta::InlineCapabilitySourceParam::OrHash).void }
        attr_writer :source

        # The type of the object. Always `inline`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Supplies a plugin ZIP directly in the session request.
        sig do
          params(

            description: String,

            name: String,

            source: OpenAI::Beta::InlineCapabilitySourceParam::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The plugin description declared in `.codex-plugin/plugin.json`.
          description:,

          # The plugin name declared in `.codex-plugin/plugin.json`.
          name:,

          # Provides ZIP bytes encoded with standard base64.
          source:,

          # The type of the object. Always `inline`.

          type: :inline
        )
        end

        sig do
          override.returns(
            {description: String, name: String, source: OpenAI::Beta::InlineCapabilitySourceParam, type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
