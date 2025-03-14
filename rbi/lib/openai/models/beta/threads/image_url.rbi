# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURL < OpenAI::BaseModel
          # The external URL of the image, must be a supported image types: jpeg, jpg, png,
          #   gif, webp.
          sig { returns(String) }
          def url
          end

          sig { params(_: String).returns(String) }
          def url=(_)
          end

          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #   to high resolution using `high`. Default value is `auto`
          sig { returns(T.nilable(Symbol)) }
          def detail
          end

          sig { params(_: Symbol).returns(Symbol) }
          def detail=(_)
          end

          sig { params(url: String, detail: Symbol).returns(T.attached_class) }
          def self.new(url:, detail: nil)
          end

          sig { override.returns({url: String, detail: Symbol}) }
          def to_hash
          end

          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #   to high resolution using `high`. Default value is `auto`
          class Detail < OpenAI::Enum
            abstract!

            AUTO = :auto
            LOW = :low
            HIGH = :high

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
end
