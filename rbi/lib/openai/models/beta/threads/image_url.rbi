# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURL < OpenAI::BaseModel
          sig { returns(String) }
          def url
          end

          sig { params(_: String).returns(String) }
          def url=(_)
          end

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
