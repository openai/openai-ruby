# typed: strong

module OpenAI
  module Models
    class ContainerRetrieveResponse < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(
            OpenAI::Models::ContainerRetrieveResponse,
            OpenAI::Internal::AnyHash
          )
        end

      # Unique identifier for the container.
      sig { returns(String) }
      attr_accessor :id

      # Unix timestamp (in seconds) when the container was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # Name of the container.
      sig { returns(String) }
      attr_accessor :name

      # The type of this object.
      sig { returns(String) }
      attr_accessor :object

      # Status of the container (e.g., active, deleted).
      sig { returns(String) }
      attr_accessor :status

      # The container will expire after this time period. The anchor is the reference
      # point for the expiration. The minutes is the number of minutes after the anchor
      # before the container expires.
      sig do
        returns(
          T.nilable(OpenAI::Models::ContainerRetrieveResponse::ExpiresAfter)
        )
      end
      attr_reader :expires_after

      sig do
        params(
          expires_after:
            OpenAI::Models::ContainerRetrieveResponse::ExpiresAfter::OrHash
        ).void
      end
      attr_writer :expires_after

      sig do
        params(
          id: String,
          created_at: Integer,
          name: String,
          object: String,
          status: String,
          expires_after:
            OpenAI::Models::ContainerRetrieveResponse::ExpiresAfter::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # Unique identifier for the container.
        id:,
        # Unix timestamp (in seconds) when the container was created.
        created_at:,
        # Name of the container.
        name:,
        # The type of this object.
        object:,
        # Status of the container (e.g., active, deleted).
        status:,
        # The container will expire after this time period. The anchor is the reference
        # point for the expiration. The minutes is the number of minutes after the anchor
        # before the container expires.
        expires_after: nil
      )
      end

      sig do
        override.returns(
          {
            id: String,
            created_at: Integer,
            name: String,
            object: String,
            status: String,
            expires_after:
              OpenAI::Models::ContainerRetrieveResponse::ExpiresAfter
          }
        )
      end
      def to_hash
      end

      class ExpiresAfter < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Models::ContainerRetrieveResponse::ExpiresAfter,
              OpenAI::Internal::AnyHash
            )
          end

        # The reference point for the expiration.
        sig do
          returns(
            T.nilable(
              OpenAI::Models::ContainerRetrieveResponse::ExpiresAfter::Anchor::TaggedSymbol
            )
          )
        end
        attr_reader :anchor

        sig do
          params(
            anchor:
              OpenAI::Models::ContainerRetrieveResponse::ExpiresAfter::Anchor::OrSymbol
          ).void
        end
        attr_writer :anchor

        # The number of minutes after the anchor before the container expires.
        sig { returns(T.nilable(Integer)) }
        attr_reader :minutes

        sig { params(minutes: Integer).void }
        attr_writer :minutes

        # The container will expire after this time period. The anchor is the reference
        # point for the expiration. The minutes is the number of minutes after the anchor
        # before the container expires.
        sig do
          params(
            anchor:
              OpenAI::Models::ContainerRetrieveResponse::ExpiresAfter::Anchor::OrSymbol,
            minutes: Integer
          ).returns(T.attached_class)
        end
        def self.new(
          # The reference point for the expiration.
          anchor: nil,
          # The number of minutes after the anchor before the container expires.
          minutes: nil
        )
        end

        sig do
          override.returns(
            {
              anchor:
                OpenAI::Models::ContainerRetrieveResponse::ExpiresAfter::Anchor::TaggedSymbol,
              minutes: Integer
            }
          )
        end
        def to_hash
        end

        # The reference point for the expiration.
        module Anchor
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Models::ContainerRetrieveResponse::ExpiresAfter::Anchor
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LAST_ACTIVE_AT =
            T.let(
              :last_active_at,
              OpenAI::Models::ContainerRetrieveResponse::ExpiresAfter::Anchor::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Models::ContainerRetrieveResponse::ExpiresAfter::Anchor::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
