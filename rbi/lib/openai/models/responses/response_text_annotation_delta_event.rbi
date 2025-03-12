# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseTextAnnotationDeltaEvent < OpenAI::BaseModel
        sig do
          returns(
            T.any(
              OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation,
              OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation,
              OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath
            )
          )
        end
        def annotation
        end

        sig do
          params(
            _: T.any(
              OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation,
              OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation,
              OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath
            )
          )
            .returns(
              T.any(
                OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation,
                OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation,
                OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath
              )
            )
        end
        def annotation=(_)
        end

        sig { returns(Integer) }
        def annotation_index
        end

        sig { params(_: Integer).returns(Integer) }
        def annotation_index=(_)
        end

        sig { returns(Integer) }
        def content_index
        end

        sig { params(_: Integer).returns(Integer) }
        def content_index=(_)
        end

        sig { returns(String) }
        def item_id
        end

        sig { params(_: String).returns(String) }
        def item_id=(_)
        end

        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig do
          params(
            annotation: T.any(
              OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation,
              OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation,
              OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath
            ),
            annotation_index: Integer,
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          annotation:,
          annotation_index:,
          content_index:,
          item_id:,
          output_index:,
          type: :"response.output_text.annotation.added"
        )
        end

        sig do
          override
            .returns(
              {
                annotation: T.any(
                  OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation,
                  OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation,
                  OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath
                ),
                annotation_index: Integer,
                content_index: Integer,
                item_id: String,
                output_index: Integer,
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
                  [[Symbol, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation], [Symbol, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation], [Symbol, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath]]
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
