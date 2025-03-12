# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputText < OpenAI::BaseModel
        sig do
          returns(
            T::Array[
            T.any(
              OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation,
              OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation,
              OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath
            )
            ]
          )
        end
        def annotations
        end

        sig do
          params(
            _: T::Array[
            T.any(
              OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation,
              OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation,
              OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath
            )
            ]
          )
            .returns(
              T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation,
                OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation,
                OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath
              )
              ]
            )
        end
        def annotations=(_)
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
            annotations: T::Array[
            T.any(
              OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation,
              OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation,
              OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath
            )
            ],
            text: String,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(annotations:, text:, type: :output_text)
        end

        sig do
          override
            .returns(
              {
                annotations: T::Array[
                T.any(
                  OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation,
                  OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation,
                  OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath
                )
                ],
                text: String,
                type: Symbol
              }
            )
        end
        def to_hash
        end

        class Annotation < OpenAI::Union
          abstract!

          class FileCitation < OpenAI::BaseModel
            sig { returns(String) }
            def file_id
            end

            sig { params(_: String).returns(String) }
            def file_id=(_)
            end

            sig { returns(Integer) }
            def index
            end

            sig { params(_: Integer).returns(Integer) }
            def index=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { params(file_id: String, index: Integer, type: Symbol).returns(T.attached_class) }
            def self.new(file_id:, index:, type: :file_citation)
            end

            sig { override.returns({file_id: String, index: Integer, type: Symbol}) }
            def to_hash
            end
          end

          class URLCitation < OpenAI::BaseModel
            sig { returns(Integer) }
            def end_index
            end

            sig { params(_: Integer).returns(Integer) }
            def end_index=(_)
            end

            sig { returns(Integer) }
            def start_index
            end

            sig { params(_: Integer).returns(Integer) }
            def start_index=(_)
            end

            sig { returns(String) }
            def title
            end

            sig { params(_: String).returns(String) }
            def title=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { returns(String) }
            def url
            end

            sig { params(_: String).returns(String) }
            def url=(_)
            end

            sig do
              params(end_index: Integer, start_index: Integer, title: String, url: String, type: Symbol)
                .returns(T.attached_class)
            end
            def self.new(end_index:, start_index:, title:, url:, type: :url_citation)
            end

            sig do
              override.returns(
                {
                  end_index: Integer,
                  start_index: Integer,
                  title: String,
                  type: Symbol,
                  url: String
                }
              )
            end
            def to_hash
            end
          end

          class FilePath < OpenAI::BaseModel
            sig { returns(String) }
            def file_id
            end

            sig { params(_: String).returns(String) }
            def file_id=(_)
            end

            sig { returns(Integer) }
            def index
            end

            sig { params(_: Integer).returns(Integer) }
            def index=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { params(file_id: String, index: Integer, type: Symbol).returns(T.attached_class) }
            def self.new(file_id:, index:, type: :file_path)
            end

            sig { override.returns({file_id: String, index: Integer, type: Symbol}) }
            def to_hash
            end
          end

          class << self
            sig do
              override
                .returns(
                  [[Symbol, OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation], [Symbol, OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation], [Symbol, OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath]]
                )
            end
            private def variants
            end
          end
        end
      end
    end
  end
end
