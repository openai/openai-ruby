# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLDelta < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          # to high resolution using `high`.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol
              )
            )
          end
          attr_reader :detail

          sig do
            params(
              detail: OpenAI::Beta::Threads::ImageURLDelta::Detail::OrSymbol
            ).void
          end
          attr_writer :detail

          # The URL of the image, must be a supported image types: jpeg, jpg, png, gif,
          # webp.
          sig { returns(T.nilable(String)) }
          attr_reader :url

          sig { params(url: String).void }
          attr_writer :url

          sig do
            params(
              detail: OpenAI::Beta::Threads::ImageURLDelta::Detail::OrSymbol,
              url: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
            # to high resolution using `high`.
            detail: nil,
            # The URL of the image, must be a supported image types: jpeg, jpg, png, gif,
            # webp.
            url: nil
          )
          end

          sig do
            override.returns(
              {
                detail:
                  OpenAI::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol,
                url: String
              }
            )
          end
          def to_hash
          end

          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          # to high resolution using `high`.
          module Detail
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Beta::Threads::ImageURLDelta::Detail)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol
              )
            LOW =
              T.let(
                :low,
                OpenAI::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol
              )
            HIGH =
              T.let(
                :high,
                OpenAI::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol
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
end
