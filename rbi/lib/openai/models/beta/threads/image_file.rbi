# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFile < OpenAI::BaseModel
          sig { returns(String) }
          def file_id
          end

          sig { params(_: String).returns(String) }
          def file_id=(_)
          end

          sig { returns(T.nilable(Symbol)) }
          def detail
          end

          sig { params(_: Symbol).returns(Symbol) }
          def detail=(_)
          end

          sig { params(file_id: String, detail: Symbol).returns(T.attached_class) }
          def self.new(file_id:, detail: nil)
          end

          sig { override.returns({file_id: String, detail: Symbol}) }
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
