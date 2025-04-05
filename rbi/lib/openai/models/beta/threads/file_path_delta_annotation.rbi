# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class FilePathDeltaAnnotation < OpenAI::Internal::Type::BaseModel
          # The index of the annotation in the text content part.
          sig { returns(Integer) }
          attr_accessor :index

          # Always `file_path`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(Integer)) }
          attr_reader :end_index

          sig { params(end_index: Integer).void }
          attr_writer :end_index

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation::FilePath)) }
          attr_reader :file_path

          sig do
            params(
              file_path: T.any(OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation::FilePath, OpenAI::Internal::AnyHash)
            )
              .void
          end
          attr_writer :file_path

          sig { returns(T.nilable(Integer)) }
          attr_reader :start_index

          sig { params(start_index: Integer).void }
          attr_writer :start_index

          # The text in the message content that needs to be replaced.
          sig { returns(T.nilable(String)) }
          attr_reader :text

          sig { params(text: String).void }
          attr_writer :text

          # A URL for the file that's generated when the assistant used the
          #   `code_interpreter` tool to generate a file.
          sig do
            params(
              index: Integer,
              end_index: Integer,
              file_path: T.any(OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation::FilePath, OpenAI::Internal::AnyHash),
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
          def to_hash; end

          class FilePath < OpenAI::Internal::Type::BaseModel
            # The ID of the file that was generated.
            sig { returns(T.nilable(String)) }
            attr_reader :file_id

            sig { params(file_id: String).void }
            attr_writer :file_id

            sig { params(file_id: String).returns(T.attached_class) }
            def self.new(file_id: nil); end

            sig { override.returns({file_id: String}) }
            def to_hash; end
          end
        end
      end
    end
  end
end
