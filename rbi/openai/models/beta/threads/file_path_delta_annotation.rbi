# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class FilePathDeltaAnnotation < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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

          sig do
            returns(
              T.nilable(
                OpenAI::Beta::Threads::FilePathDeltaAnnotation::FilePath
              )
            )
          end
          attr_reader :file_path

          sig do
            params(
              file_path:
                OpenAI::Beta::Threads::FilePathDeltaAnnotation::FilePath::OrHash
            ).void
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
          # `code_interpreter` tool to generate a file.
          sig do
            params(
              index: Integer,
              end_index: Integer,
              file_path:
                OpenAI::Beta::Threads::FilePathDeltaAnnotation::FilePath::OrHash,
              start_index: Integer,
              text: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the annotation in the text content part.
            index:,
            end_index: nil,
            file_path: nil,
            start_index: nil,
            # The text in the message content that needs to be replaced.
            text: nil,
            # Always `file_path`.
            type: :file_path
          )
          end

          sig do
            override.returns(
              {
                index: Integer,
                type: Symbol,
                end_index: Integer,
                file_path:
                  OpenAI::Beta::Threads::FilePathDeltaAnnotation::FilePath,
                start_index: Integer,
                text: String
              }
            )
          end
          def to_hash
          end

          class FilePath < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # The ID of the file that was generated.
            sig { returns(T.nilable(String)) }
            attr_reader :file_id

            sig { params(file_id: String).void }
            attr_writer :file_id

            sig { params(file_id: String).returns(T.attached_class) }
            def self.new(
              # The ID of the file that was generated.
              file_id: nil
            )
            end

            sig { override.returns({ file_id: String }) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
