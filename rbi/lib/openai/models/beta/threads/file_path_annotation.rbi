# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class FilePathAnnotation < OpenAI::Internal::Type::BaseModel
          sig { returns(Integer) }
          attr_accessor :end_index

          sig { returns(OpenAI::Models::Beta::Threads::FilePathAnnotation::FilePath) }
          attr_reader :file_path

          sig do
            params(
              file_path: T.any(OpenAI::Models::Beta::Threads::FilePathAnnotation::FilePath, OpenAI::Internal::AnyHash)
            )
              .void
          end
          attr_writer :file_path

          sig { returns(Integer) }
          attr_accessor :start_index

          # The text in the message content that needs to be replaced.
          sig { returns(String) }
          attr_accessor :text

          # Always `file_path`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A URL for the file that's generated when the assistant used the
          #   `code_interpreter` tool to generate a file.
          sig do
            params(
              end_index: Integer,
              file_path: T.any(OpenAI::Models::Beta::Threads::FilePathAnnotation::FilePath, OpenAI::Internal::AnyHash),
              start_index: Integer,
              text: String,
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(end_index:, file_path:, start_index:, text:, type: :file_path); end

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
          def to_hash; end

          class FilePath < OpenAI::Internal::Type::BaseModel
            # The ID of the file that was generated.
            sig { returns(String) }
            attr_accessor :file_id

            sig { params(file_id: String).returns(T.attached_class) }
            def self.new(file_id:); end

            sig { override.returns({file_id: String}) }
            def to_hash; end
          end
        end
      end
    end
  end
end
