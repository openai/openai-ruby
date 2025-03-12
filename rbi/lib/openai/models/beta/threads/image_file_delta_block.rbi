# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileDeltaBlock < OpenAI::BaseModel
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

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::ImageFileDelta)) }
          def image_file
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::ImageFileDelta)
              .returns(OpenAI::Models::Beta::Threads::ImageFileDelta)
          end
          def image_file=(_)
          end

          sig do
            params(index: Integer, image_file: OpenAI::Models::Beta::Threads::ImageFileDelta, type: Symbol)
              .returns(T.attached_class)
          end
          def self.new(index:, image_file: nil, type: :image_file)
          end

          sig do
            override.returns({index: Integer, type: Symbol, image_file: OpenAI::Models::Beta::Threads::ImageFileDelta})
          end
          def to_hash
          end
        end
      end
    end
  end
end
