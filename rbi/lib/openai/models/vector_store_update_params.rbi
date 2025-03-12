# typed: strong

module OpenAI
  module Models
    class VectorStoreUpdateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      sig { returns(T.nilable(OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter)) }
      def expires_after
      end

      sig do
        params(_: T.nilable(OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter))
          .returns(T.nilable(OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter))
      end
      def expires_after=(_)
      end

      sig { returns(T.nilable(OpenAI::Models::Metadata)) }
      def metadata
      end

      sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
      def metadata=(_)
      end

      sig { returns(T.nilable(String)) }
      def name
      end

      sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
      def name=(_)
      end

      sig do
        params(
          expires_after: T.nilable(OpenAI::Models::VectorStoreUpdateParams::ExpiresAfter),
          metadata: T.nilable(OpenAI::Models::Metadata),
          name: T.nilable(String),
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
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
              metadata: T.nilable(OpenAI::Models::Metadata),
              name: T.nilable(String),
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      class ExpiresAfter < OpenAI::BaseModel
        sig { returns(Symbol) }
        def anchor
        end

        sig { params(_: Symbol).returns(Symbol) }
        def anchor=(_)
        end

        sig { returns(Integer) }
        def days
        end

        sig { params(_: Integer).returns(Integer) }
        def days=(_)
        end

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
