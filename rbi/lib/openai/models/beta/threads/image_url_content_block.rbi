# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLContentBlock < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::ImageURL) }
          attr_reader :image_url

          sig { params(image_url: T.any(OpenAI::Models::Beta::Threads::ImageURL, OpenAI::Internal::Util::AnyHash)).void }
          attr_writer :image_url

          # The type of the content part.
          sig { returns(Symbol) }
          attr_accessor :type

          # References an image URL in the content of a message.
          sig do
            params(
              image_url: T.any(OpenAI::Models::Beta::Threads::ImageURL, OpenAI::Internal::Util::AnyHash),
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(image_url:, type: :image_url)
          end

          sig { override.returns({image_url: OpenAI::Models::Beta::Threads::ImageURL, type: Symbol}) }
          def to_hash
          end
        end
      end
    end
  end
end
