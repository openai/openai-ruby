# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURL < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # The external URL of the image, must be a supported image types: jpeg, jpg, png,
          # gif, webp.
          sig { returns(String) }
          attr_accessor :url

          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          # to high resolution using `high`. Default value is `auto`
          sig do
            returns(
              T.nilable(OpenAI::Beta::Threads::ImageURL::Detail::OrSymbol)
            )
          end
          attr_reader :detail

          sig do
            params(
              detail: OpenAI::Beta::Threads::ImageURL::Detail::OrSymbol
            ).void
          end
          attr_writer :detail

          sig do
            params(
              url: String,
              detail: OpenAI::Beta::Threads::ImageURL::Detail::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The external URL of the image, must be a supported image types: jpeg, jpg, png,
            # gif, webp.
            url:,
            # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
            # to high resolution using `high`. Default value is `auto`
            detail: nil
          )
          end

          sig do
            override.returns(
              {
                url: String,
                detail: OpenAI::Beta::Threads::ImageURL::Detail::OrSymbol
              }
            )
          end
          def to_hash
          end

          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          # to high resolution using `high`. Default value is `auto`
          module Detail
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Beta::Threads::ImageURL::Detail)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Beta::Threads::ImageURL::Detail::TaggedSymbol
              )
            LOW =
              T.let(:low, OpenAI::Beta::Threads::ImageURL::Detail::TaggedSymbol)
            HIGH =
              T.let(
                :high,
                OpenAI::Beta::Threads::ImageURL::Detail::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[OpenAI::Beta::Threads::ImageURL::Detail::TaggedSymbol]
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
