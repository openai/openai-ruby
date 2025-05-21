# typed: strong

module OpenAI
  module Models
    class ContainerCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::ContainerCreateParams, OpenAI::Internal::AnyHash)
        end

      # Name of the container to create.
      sig { returns(String) }
      attr_accessor :name

      # Container expiration time in seconds relative to the 'anchor' time.
      sig { returns(T.nilable(OpenAI::ContainerCreateParams::ExpiresAfter)) }
      attr_reader :expires_after

      sig do
        params(
          expires_after: OpenAI::ContainerCreateParams::ExpiresAfter::OrHash
        ).void
      end
      attr_writer :expires_after

      # IDs of files to copy to the container.
      sig { returns(T.nilable(T::Array[String])) }
      attr_reader :file_ids

      sig { params(file_ids: T::Array[String]).void }
      attr_writer :file_ids

      sig do
        params(
          name: String,
          expires_after: OpenAI::ContainerCreateParams::ExpiresAfter::OrHash,
          file_ids: T::Array[String],
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # Name of the container to create.
        name:,
        # Container expiration time in seconds relative to the 'anchor' time.
        expires_after: nil,
        # IDs of files to copy to the container.
        file_ids: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            name: String,
            expires_after: OpenAI::ContainerCreateParams::ExpiresAfter,
            file_ids: T::Array[String],
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
              OpenAI::ContainerCreateParams::ExpiresAfter,
              OpenAI::Internal::AnyHash
            )
          end

        # Time anchor for the expiration time. Currently only 'last_active_at' is
        # supported.
        sig do
          returns(OpenAI::ContainerCreateParams::ExpiresAfter::Anchor::OrSymbol)
        end
        attr_accessor :anchor

        sig { returns(Integer) }
        attr_accessor :minutes

        # Container expiration time in seconds relative to the 'anchor' time.
        sig do
          params(
            anchor:
              OpenAI::ContainerCreateParams::ExpiresAfter::Anchor::OrSymbol,
            minutes: Integer
          ).returns(T.attached_class)
        end
        def self.new(
          # Time anchor for the expiration time. Currently only 'last_active_at' is
          # supported.
          anchor:,
          minutes:
        )
        end

        sig do
          override.returns(
            {
              anchor:
                OpenAI::ContainerCreateParams::ExpiresAfter::Anchor::OrSymbol,
              minutes: Integer
            }
          )
        end
        def to_hash
        end

        # Time anchor for the expiration time. Currently only 'last_active_at' is
        # supported.
        module Anchor
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::ContainerCreateParams::ExpiresAfter::Anchor)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LAST_ACTIVE_AT =
            T.let(
              :last_active_at,
              OpenAI::ContainerCreateParams::ExpiresAfter::Anchor::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::ContainerCreateParams::ExpiresAfter::Anchor::TaggedSymbol
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
