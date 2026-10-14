# typed: strong

module OpenAI
  module Models

    module Beta

      class HostedPlugin < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::HostedPlugin,
            OpenAI::Internal::AnyHash
          )
        end

        # The installed plugin description.
        sig { returns(String) }
        attr_accessor :description

        # The installed plugin name.
        sig { returns(String) }
        attr_accessor :name

        # The type of the object. Always `inline`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A plugin installed from an inline ZIP archive.
        sig do
          params(

            description: String,

            name: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The installed plugin description.
          description:,

          # The installed plugin name.
          name:,

          # The type of the object. Always `inline`.

          type: :inline
        )
        end

        sig do
          override.returns(
            {description: String, name: String, type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
