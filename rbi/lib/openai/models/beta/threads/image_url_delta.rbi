# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLDelta < OpenAI::BaseModel
          sig { returns(T.nilable(Symbol)) }
          def detail
          end

          sig { params(_: Symbol).returns(Symbol) }
          def detail=(_)
          end

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
