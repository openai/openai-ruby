# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class FilePathDeltaAnnotation < OpenAI::BaseModel
          # The index of the annotation in the text content part.
          sig { returns(Integer) }
          def index
          end

          sig { params(_: Integer).returns(Integer) }
          def index=(_)
          end

          # Always `file_path`.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          sig { returns(T.nilable(Integer)) }
          def end_index
          end

          sig { params(_: Integer).returns(Integer) }
          def end_index=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation::FilePath)) }
          def file_path
          end

          sig do
            params(_: T.any(OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation::FilePath, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation::FilePath, OpenAI::Util::AnyHash))
          end
          def file_path=(_)
          end

          sig { returns(T.nilable(Integer)) }
          def start_index
          end

          sig { params(_: Integer).returns(Integer) }
          def start_index=(_)
          end

          # The text in the message content that needs to be replaced.
          sig { returns(T.nilable(String)) }
          def text
          end

          sig { params(_: String).returns(String) }
          def text=(_)
          end

          # A URL for the file that's generated when the assistant used the
          #   `code_interpreter` tool to generate a file.
          sig do
            params(
              index: Integer,
              end_index: Integer,
              file_path: T.any(OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation::FilePath, OpenAI::Util::AnyHash),
              start_index: Integer,
              text: String,
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(index:, end_index: nil, file_path: nil, start_index: nil, text: nil, type: :file_path)
          end

          sig do
            override
              .returns(
                {
                  index: Integer,
                  type: Symbol,
                  end_index: Integer,
                  file_path: OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation::FilePath,
                  start_index: Integer,
                  text: String
                }
              )
          end
          def to_hash
          end

          class FilePath < OpenAI::BaseModel
            # The ID of the file that was generated.
            sig { returns(T.nilable(String)) }
            def file_id
            end

            sig { params(_: String).returns(String) }
            def file_id=(_)
            end

            sig { params(file_id: String).returns(T.attached_class) }
            def self.new(file_id: nil)
            end

            sig { override.returns({file_id: String}) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
