# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLDeltaBlock < OpenAI::BaseModel
          # The index of the content part in the message.
          sig { returns(Integer) }
          def index
          end

          sig { params(_: Integer).returns(Integer) }
          def index=(_)
          end

          # Always `image_url`.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::ImageURLDelta)) }
          def image_url
          end

          sig do
            params(_: T.any(OpenAI::Models::Beta::Threads::ImageURLDelta, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::ImageURLDelta, OpenAI::Util::AnyHash))
          end
          def image_url=(_)
          end

          # References an image URL in the content of a message.
          sig do
            params(
              index: Integer,
              image_url: T.any(OpenAI::Models::Beta::Threads::ImageURLDelta, OpenAI::Util::AnyHash),
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(index:, image_url: nil, type: :image_url)
          end

          sig { override.returns({index: Integer, type: Symbol, image_url: OpenAI::Models::Beta::Threads::ImageURLDelta}) }
          def to_hash
          end
        end
      end
    end
  end
end
