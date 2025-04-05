# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseTextAnnotationDeltaEvent < OpenAI::Internal::Type::BaseModel
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
        attr_accessor :annotation

        # The index of the annotation that was added.
        sig { returns(Integer) }
        attr_accessor :annotation_index

        # The index of the content part that the text annotation was added to.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The ID of the output item that the text annotation was added to.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the text annotation was added to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always `response.output_text.annotation.added`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a text annotation is added.
        sig do
          params(
            annotation: T.any(
              OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation,
              OpenAI::Internal::AnyHash,
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
        ); end
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
        def to_hash; end

        # A citation to a file.
        module Annotation
          extend OpenAI::Internal::Type::Union

          class FileCitation < OpenAI::Internal::Type::BaseModel
            # The ID of the file.
            sig { returns(String) }
            attr_accessor :file_id

            # The index of the file in the list of files.
            sig { returns(Integer) }
            attr_accessor :index

            # The type of the file citation. Always `file_citation`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A citation to a file.
            sig { params(file_id: String, index: Integer, type: Symbol).returns(T.attached_class) }
            def self.new(file_id:, index:, type: :file_citation); end

            sig { override.returns({file_id: String, index: Integer, type: Symbol}) }
            def to_hash; end
          end

          class URLCitation < OpenAI::Internal::Type::BaseModel
            # The index of the last character of the URL citation in the message.
            sig { returns(Integer) }
            attr_accessor :end_index

            # The index of the first character of the URL citation in the message.
            sig { returns(Integer) }
            attr_accessor :start_index

            # The title of the web resource.
            sig { returns(String) }
            attr_accessor :title

            # The type of the URL citation. Always `url_citation`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The URL of the web resource.
            sig { returns(String) }
            attr_accessor :url

            # A citation for a web resource used to generate a model response.
            sig do
              params(end_index: Integer, start_index: Integer, title: String, url: String, type: Symbol)
                .returns(T.attached_class)
            end
            def self.new(end_index:, start_index:, title:, url:, type: :url_citation); end

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
            def to_hash; end
          end

          class FilePath < OpenAI::Internal::Type::BaseModel
            # The ID of the file.
            sig { returns(String) }
            attr_accessor :file_id

            # The index of the file in the list of files.
            sig { returns(Integer) }
            attr_accessor :index

            # The type of the file path. Always `file_path`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A path to a file.
            sig { params(file_id: String, index: Integer, type: Symbol).returns(T.attached_class) }
            def self.new(file_id:, index:, type: :file_path); end

            sig { override.returns({file_id: String, index: Integer, type: Symbol}) }
            def to_hash; end
          end

          sig do
            override
              .returns(
                [OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath]
              )
          end
          def self.variants; end
        end
      end
    end
  end
end
