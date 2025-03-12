# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class FileCitationAnnotation < OpenAI::BaseModel
          sig { returns(Integer) }
          def end_index
          end

          sig { params(_: Integer).returns(Integer) }
          def end_index=(_)
          end

          sig { returns(OpenAI::Models::Beta::Threads::FileCitationAnnotation::FileCitation) }
          def file_citation
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::FileCitationAnnotation::FileCitation)
              .returns(OpenAI::Models::Beta::Threads::FileCitationAnnotation::FileCitation)
          end
          def file_citation=(_)
          end

          sig { returns(Integer) }
          def start_index
          end

          sig { params(_: Integer).returns(Integer) }
          def start_index=(_)
          end

          sig { returns(String) }
          def text
          end

          sig { params(_: String).returns(String) }
          def text=(_)
          end

          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          sig do
            params(
              end_index: Integer,
              file_citation: OpenAI::Models::Beta::Threads::FileCitationAnnotation::FileCitation,
              start_index: Integer,
              text: String,
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(end_index:, file_citation:, start_index:, text:, type: :file_citation)
          end

          sig do
            override
              .returns(
                {
                  end_index: Integer,
                  file_citation: OpenAI::Models::Beta::Threads::FileCitationAnnotation::FileCitation,
                  start_index: Integer,
                  text: String,
                  type: Symbol
                }
              )
          end
          def to_hash
          end

          class FileCitation < OpenAI::BaseModel
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
