# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLDeltaBlock < OpenAI::BaseModel
          sig { returns(Integer) }
          def index
          end

          sig { params(_: Integer).returns(Integer) }
          def index=(_)
          end

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
            params(_: OpenAI::Models::Beta::Threads::ImageURLDelta)
              .returns(OpenAI::Models::Beta::Threads::ImageURLDelta)
          end
          def image_url=(_)
          end

          sig do
            params(index: Integer, image_url: OpenAI::Models::Beta::Threads::ImageURLDelta, type: Symbol)
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
