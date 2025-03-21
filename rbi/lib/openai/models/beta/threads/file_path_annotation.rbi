# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class FilePathAnnotation < OpenAI::BaseModel
          sig { returns(Integer) }
          def end_index
          end

          sig { params(_: Integer).returns(Integer) }
          def end_index=(_)
          end

          sig { returns(OpenAI::Models::Beta::Threads::FilePathAnnotation::FilePath) }
          def file_path
          end

          sig do
            params(_: T.any(OpenAI::Models::Beta::Threads::FilePathAnnotation::FilePath, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::FilePathAnnotation::FilePath, OpenAI::Util::AnyHash))
          end
          def file_path=(_)
          end

          sig { returns(Integer) }
          def start_index
          end

          sig { params(_: Integer).returns(Integer) }
          def start_index=(_)
          end

          # The text in the message content that needs to be replaced.
          sig { returns(String) }
          def text
          end

          sig { params(_: String).returns(String) }
          def text=(_)
          end

          # Always `file_path`.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          # A URL for the file that's generated when the assistant used the
          #   `code_interpreter` tool to generate a file.
          sig do
            params(
              end_index: Integer,
              file_path: T.any(OpenAI::Models::Beta::Threads::FilePathAnnotation::FilePath, OpenAI::Util::AnyHash),
              start_index: Integer,
              text: String,
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(end_index:, file_path:, start_index:, text:, type: :file_path)
          end

          sig do
            override
              .returns(
                {
                  end_index: Integer,
                  file_path: OpenAI::Models::Beta::Threads::FilePathAnnotation::FilePath,
                  start_index: Integer,
                  text: String,
                  type: Symbol
                }
              )
          end
          def to_hash
          end

          class FilePath < OpenAI::BaseModel
            # The ID of the file that was generated.
            sig { returns(String) }
            def file_id
            end

            sig { params(_: String).returns(String) }
            def file_id=(_)
            end

            sig { params(file_id: String).returns(T.attached_class) }
            def self.new(file_id:)
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
