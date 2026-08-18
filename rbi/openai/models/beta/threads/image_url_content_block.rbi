# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLContentBlock < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::Threads::ImageURLContentBlock,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(OpenAI::Beta::Threads::ImageURL) }
          attr_reader :image_url

          sig do
            params(image_url: OpenAI::Beta::Threads::ImageURL::OrHash).void
          end
          attr_writer :image_url

          # The type of the content part.
          sig { returns(Symbol) }
          attr_accessor :type

          # References an image URL in the content of a message.
          sig do
            params(
              image_url: OpenAI::Beta::Threads::ImageURL::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            image_url:,
            # The type of the content part.
            type: :image_url
          )
          end

          sig do
            override.returns(
              { image_url: OpenAI::Beta::Threads::ImageURL, type: Symbol }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
