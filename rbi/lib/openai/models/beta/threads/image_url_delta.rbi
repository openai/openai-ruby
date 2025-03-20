# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLDelta < OpenAI::BaseModel
          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #   to high resolution using `high`.
          sig { returns(T.nilable(Symbol)) }
          def detail
          end

          sig { params(_: Symbol).returns(Symbol) }
          def detail=(_)
          end

          # The URL of the image, must be a supported image types: jpeg, jpg, png, gif,
          #   webp.
          sig { returns(T.nilable(String)) }
          def url
          end

          sig { params(_: String).returns(String) }
          def url=(_)
          end

          sig { params(detail: Symbol, url: String).returns(T.attached_class) }
          def self.new(detail: nil, url: nil)
          end

          sig { override.returns({detail: Symbol, url: String}) }
          def to_hash
          end

          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #   to high resolution using `high`.
          class Detail < OpenAI::Enum
            abstract!

            Value = type_template(:out) { {fixed: Symbol} }

            AUTO = :auto
            LOW = :low
            HIGH = :high
          end
        end
      end
    end
  end
end
