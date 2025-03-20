# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileDelta < OpenAI::BaseModel
          # Specifies the detail level of the image if specified by the user. `low` uses
          #   fewer tokens, you can opt in to high resolution using `high`.
          sig { returns(T.nilable(Symbol)) }
          def detail
          end

          sig { params(_: Symbol).returns(Symbol) }
          def detail=(_)
          end

          # The [File](https://platform.openai.com/docs/api-reference/files) ID of the image
          #   in the message content. Set `purpose="vision"` when uploading the File if you
          #   need to later display the file content.
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

          # Specifies the detail level of the image if specified by the user. `low` uses
          #   fewer tokens, you can opt in to high resolution using `high`.
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
