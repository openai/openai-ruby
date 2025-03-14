# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class FileCitationDeltaAnnotation < OpenAI::BaseModel
          # The index of the annotation in the text content part.
          sig { returns(Integer) }
          def index
          end

          sig { params(_: Integer).returns(Integer) }
          def index=(_)
          end

          # Always `file_citation`.
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

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation::FileCitation)) }
          def file_citation
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation::FileCitation)
              .returns(OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation::FileCitation)
          end
          def file_citation=(_)
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

          # A citation within the message that points to a specific quote from a specific
          #   File associated with the assistant or the message. Generated when the assistant
          #   uses the "file_search" tool to search files.
          sig do
            params(
              index: Integer,
              end_index: Integer,
              file_citation: OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation::FileCitation,
              start_index: Integer,
              text: String,
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(index:, end_index: nil, file_citation: nil, start_index: nil, text: nil, type: :file_citation)
          end

          sig do
            override
              .returns(
                {
                  index: Integer,
                  type: Symbol,
                  end_index: Integer,
                  file_citation: OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation::FileCitation,
                  start_index: Integer,
                  text: String
                }
              )
          end
          def to_hash
          end

          class FileCitation < OpenAI::BaseModel
            # The ID of the specific File the citation is from.
            sig { returns(T.nilable(String)) }
            def file_id
            end

            sig { params(_: String).returns(String) }
            def file_id=(_)
            end

            # The specific quote in the file.
            sig { returns(T.nilable(String)) }
            def quote
            end

            sig { params(_: String).returns(String) }
            def quote=(_)
            end

            sig { params(file_id: String, quote: String).returns(T.attached_class) }
            def self.new(file_id: nil, quote: nil)
            end

            sig { override.returns({file_id: String, quote: String}) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
