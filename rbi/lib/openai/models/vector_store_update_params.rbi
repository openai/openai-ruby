# typed: strong

module OpenAI
  module Models
    class VectorStoreUpdateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # The expiration policy for a vector store.
      sig { returns(T.nilable(OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter)) }
      def expires_after
      end

      sig do
        params(_: T.nilable(T.any(OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter, OpenAI::Util::AnyHash)))
          .returns(T.nilable(T.any(OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter, OpenAI::Util::AnyHash)))
      end
      def expires_after=(_)
      end

      # Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard.
      #
      #   Keys are strings with a maximum length of 64 characters. Values are strings with
      #   a maximum length of 512 characters.
      sig { returns(T.nilable(T::Hash[Symbol, String])) }
      def metadata
      end

      sig { params(_: T.nilable(T::Hash[Symbol, String])).returns(T.nilable(T::Hash[Symbol, String])) }
      def metadata=(_)
      end

      # The name of the vector store.
      sig { returns(T.nilable(String)) }
      def name
      end

      sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
      def name=(_)
      end

      sig do
        params(
          expires_after: T.nilable(T.any(OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter, OpenAI::Util::AnyHash)),
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: T.nilable(String),
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(expires_after: nil, metadata: nil, name: nil, request_options: {})
      end

      sig do
        override
          .returns(
            {
              expires_after: T.nilable(OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter),
              metadata: T.nilable(T::Hash[Symbol, String]),
              name: T.nilable(String),
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      class ExpiresAfter < OpenAI::BaseModel
        # Anchor timestamp after which the expiration policy applies. Supported anchors:
        #   `last_active_at`.
        sig { returns(Symbol) }
        def anchor
        end

        sig { params(_: Symbol).returns(Symbol) }
        def anchor=(_)
        end

        # The number of days after the anchor time that the vector store will expire.
        sig { returns(Integer) }
        def days
        end

        sig { params(_: Integer).returns(Integer) }
        def days=(_)
        end

        # The expiration policy for a vector store.
        sig { params(days: Integer, anchor: Symbol).returns(T.attached_class) }
        def self.new(days:, anchor: :last_active_at)
        end

        sig { override.returns({anchor: Symbol, days: Integer}) }
        def to_hash
        end
      end
    end
  end
end
