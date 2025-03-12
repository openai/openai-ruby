# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLContentBlock < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::ImageURL) }
          def image_url
          end

          sig { params(_: OpenAI::Models::Beta::Threads::ImageURL).returns(OpenAI::Models::Beta::Threads::ImageURL) }
          def image_url=(_)
          end

          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          sig { params(image_url: OpenAI::Models::Beta::Threads::ImageURL, type: Symbol).returns(T.attached_class) }
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
