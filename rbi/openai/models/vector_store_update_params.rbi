# typed: strong

module OpenAI
  module Models
    class VectorStoreUpdateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::VectorStoreUpdateParams, OpenAI::Internal::AnyHash)
        end

      # The expiration policy for a vector store.
      sig { returns(T.nilable(OpenAI::VectorStoreUpdateParams::ExpiresAfter)) }
      attr_reader :expires_after

      sig do
        params(
          expires_after:
            T.nilable(OpenAI::VectorStoreUpdateParams::ExpiresAfter::OrHash)
        ).void
      end
      attr_writer :expires_after

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      # for storing additional information about the object in a structured format, and
      # querying for objects via API or the dashboard.
      #
      # Keys are strings with a maximum length of 64 characters. Values are strings with
      # a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      attr_accessor :metadata

      # The name of the vector store.
      sig { returns(T.nilable(String)) }
      attr_accessor :name

      sig do
        params(
          expires_after:
            T.nilable(OpenAI::VectorStoreUpdateParams::ExpiresAfter::OrHash),
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: T.nilable(String),
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # The expiration policy for a vector store.
        expires_after: nil,
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        metadata: nil,
        # The name of the vector store.
        name: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            expires_after:
              T.nilable(OpenAI::VectorStoreUpdateParams::ExpiresAfter),
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: T.nilable(String),
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      class ExpiresAfter < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::VectorStoreUpdateParams::ExpiresAfter,
              OpenAI::Internal::AnyHash
            )
          end

        # Anchor timestamp after which the expiration policy applies. Supported anchors:
        # `last_active_at`.
        sig { returns(Symbol) }
        attr_accessor :anchor

        # The number of days after the anchor time that the vector store will expire.
        sig { returns(Integer) }
        attr_accessor :days

        # The expiration policy for a vector store.
        sig { params(days: Integer, anchor: Symbol).returns(T.attached_class) }
        def self.new(
          # The number of days after the anchor time that the vector store will expire.
          days:,
          # Anchor timestamp after which the expiration policy applies. Supported anchors:
          # `last_active_at`.
          anchor: :last_active_at
        )
        end

        sig { override.returns({ anchor: Symbol, days: Integer }) }
        def to_hash
        end
      end
    end
  end
end
