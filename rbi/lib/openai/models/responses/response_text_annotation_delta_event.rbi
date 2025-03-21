# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseTextAnnotationDeltaEvent < OpenAI::BaseModel
        # A citation to a file.
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

        # The index of the annotation that was added.
        sig { returns(Integer) }
        def annotation_index
        end

        sig { params(_: Integer).returns(Integer) }
        def annotation_index=(_)
        end

        # The index of the content part that the text annotation was added to.
        sig { returns(Integer) }
        def content_index
        end

        sig { params(_: Integer).returns(Integer) }
        def content_index=(_)
        end

        # The ID of the output item that the text annotation was added to.
        sig { returns(String) }
        def item_id
        end

        sig { params(_: String).returns(String) }
        def item_id=(_)
        end

        # The index of the output item that the text annotation was added to.
        sig { returns(Integer) }
        def output_index
        end

        sig { params(_: Integer).returns(Integer) }
        def output_index=(_)
        end

        # The type of the event. Always `response.output_text.annotation.added`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when a text annotation is added.
        sig do
          params(
            annotation: T.any(
              OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation,
              OpenAI::Util::AnyHash,
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

        # A citation to a file.
        module Annotation
          extend OpenAI::Union

          Variants =
            type_template(:out) do
              {
                fixed: T.any(
                  OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation,
                  OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation,
                  OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath
                )
              }
            end

          class FileCitation < OpenAI::BaseModel
            # The ID of the file.
            sig { returns(String) }
            def file_id
            end

            sig { params(_: String).returns(String) }
            def file_id=(_)
            end

            # The index of the file in the list of files.
            sig { returns(Integer) }
            def index
            end

            sig { params(_: Integer).returns(Integer) }
            def index=(_)
            end

            # The type of the file citation. Always `file_citation`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # A citation to a file.
            sig { params(file_id: String, index: Integer, type: Symbol).returns(T.attached_class) }
            def self.new(file_id:, index:, type: :file_citation)
            end

            sig { override.returns({file_id: String, index: Integer, type: Symbol}) }
            def to_hash
            end
          end

          class URLCitation < OpenAI::BaseModel
            # The index of the last character of the URL citation in the message.
            sig { returns(Integer) }
            def end_index
            end

            sig { params(_: Integer).returns(Integer) }
            def end_index=(_)
            end

            # The index of the first character of the URL citation in the message.
            sig { returns(Integer) }
            def start_index
            end

            sig { params(_: Integer).returns(Integer) }
            def start_index=(_)
            end

            # The title of the web resource.
            sig { returns(String) }
            def title
            end

            sig { params(_: String).returns(String) }
            def title=(_)
            end

            # The type of the URL citation. Always `url_citation`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The URL of the web resource.
            sig { returns(String) }
            def url
            end

            sig { params(_: String).returns(String) }
            def url=(_)
            end

            # A citation for a web resource used to generate a model response.
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
            # The ID of the file.
            sig { returns(String) }
            def file_id
            end

            sig { params(_: String).returns(String) }
            def file_id=(_)
            end

            # The index of the file in the list of files.
            sig { returns(Integer) }
            def index
            end

            sig { params(_: Integer).returns(Integer) }
            def index=(_)
            end

            # The type of the file path. Always `file_path`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # A path to a file.
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
                  [OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath]
                )
            end
            def variants
            end
          end
        end
      end
    end
  end
end
