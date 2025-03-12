# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputImage < OpenAI::BaseModel
        sig { returns(Symbol) }
        def detail
        end

        sig { params(_: Symbol).returns(Symbol) }
        def detail=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { returns(T.nilable(String)) }
        def file_id
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def file_id=(_)
        end

        sig { returns(T.nilable(String)) }
        def image_url
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def image_url=(_)
        end

        sig do
          params(detail: Symbol, file_id: T.nilable(String), image_url: T.nilable(String), type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(detail:, file_id: nil, image_url: nil, type: :input_image)
        end

        sig do
          override.returns(
            {
              detail: Symbol,
              type: Symbol,
              file_id: T.nilable(String),
              image_url: T.nilable(String)
            }
          )
        end
        def to_hash
        end

        class Detail < OpenAI::Enum
          abstract!

          HIGH = :high
          LOW = :low
          AUTO = :auto

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
