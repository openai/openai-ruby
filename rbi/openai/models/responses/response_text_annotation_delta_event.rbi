# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseTextAnnotationDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseTextAnnotationDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # A citation to a file.
        sig do
          returns(
            OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::Variants
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
            annotation:
              T.any(
                OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation::OrHash,
                OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation::OrHash,
                OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath::OrHash
              ),
            annotation_index: Integer,
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A citation to a file.
          annotation:,
          # The index of the annotation that was added.
          annotation_index:,
          # The index of the content part that the text annotation was added to.
          content_index:,
          # The ID of the output item that the text annotation was added to.
          item_id:,
          # The index of the output item that the text annotation was added to.
          output_index:,
          # The type of the event. Always `response.output_text.annotation.added`.
          type: :"response.output_text.annotation.added"
        )
        end

        sig do
          override.returns(
            {
              annotation:
                OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::Variants,
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
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation,
                OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation,
                OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath
              )
            end

          class FileCitation < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation,
                  OpenAI::Internal::AnyHash
                )
              end

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
            sig do
              params(file_id: String, index: Integer, type: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # The ID of the file.
              file_id:,
              # The index of the file in the list of files.
              index:,
              # The type of the file citation. Always `file_citation`.
              type: :file_citation
            )
            end

            sig do
              override.returns(
                { file_id: String, index: Integer, type: Symbol }
              )
            end
            def to_hash
            end
          end

          class URLCitation < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation,
                  OpenAI::Internal::AnyHash
                )
              end

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
              params(
                end_index: Integer,
                start_index: Integer,
                title: String,
                url: String,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The index of the last character of the URL citation in the message.
              end_index:,
              # The index of the first character of the URL citation in the message.
              start_index:,
              # The title of the web resource.
              title:,
              # The URL of the web resource.
              url:,
              # The type of the URL citation. Always `url_citation`.
              type: :url_citation
            )
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

          class FilePath < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath,
                  OpenAI::Internal::AnyHash
                )
              end

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
            sig do
              params(file_id: String, index: Integer, type: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # The ID of the file.
              file_id:,
              # The index of the file in the list of files.
              index:,
              # The type of the file path. Always `file_path`.
              type: :file_path
            )
            end

            sig do
              override.returns(
                { file_id: String, index: Integer, type: Symbol }
              )
            end
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::Variants
              ]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
