# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileDelta < OpenAI::BaseModel
          sig { returns(T.nilable(Symbol)) }
          def detail
          end

          sig { params(_: Symbol).returns(Symbol) }
          def detail=(_)
          end

          sig { returns(T.nilable(String)) }
          def file_id
          end

          sig { params(_: String).returns(String) }
          def file_id=(_)
          end

          sig { params(detail: Symbol, file_id: String).returns(T.attached_class) }
          def self.new(detail: nil, file_id: nil)
          end

          sig { override.returns({detail: Symbol, file_id: String}) }
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
