# typed: strong

module OpenAI
  module Models
    BetaResponseOutputTextAnnotationAddedEvent =
      Beta::BetaResponseOutputTextAnnotationAddedEvent

    module Beta
      class BetaResponseOutputTextAnnotationAddedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # An annotation that applies to a span of output text.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::Variants
            )
          )
        end
        attr_accessor :annotation

        # The index of the annotation within the content part.
        sig { returns(Integer) }
        attr_accessor :annotation_index

        # The index of the content part within the output item.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The unique identifier of the item to which the annotation is being added.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response's output array.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always 'response.output_text.annotation.added'.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when an annotation is added to output text content.
        sig do
          params(
            annotation:
              T.nilable(
                T.any(
                  OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::FileCitation::OrHash,
                  OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::URLCitation::OrHash,
                  OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::ContainerFileCitation::OrHash,
                  OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::FilePath::OrHash
                )
              ),
            annotation_index: Integer,
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # An annotation that applies to a span of output text.
          annotation:,
          # The index of the annotation within the content part.
          annotation_index:,
          # The index of the content part within the output item.
          content_index:,
          # The unique identifier of the item to which the annotation is being added.
          item_id:,
          # The index of the output item in the response's output array.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always 'response.output_text.annotation.added'.
          type: :"response.output_text.annotation.added"
        )
        end

        sig do
          override.returns(
            {
              annotation:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::Variants
                ),
              annotation_index: Integer,
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Agent
                )
            }
          )
        end
        def to_hash
        end

        # An annotation that applies to a span of output text.
        module Annotation
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::FileCitation,
                OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::URLCitation,
                OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::ContainerFileCitation,
                OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::FilePath
              )
            end

          class FileCitation < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::FileCitation,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the file.
            sig { returns(String) }
            attr_accessor :file_id

            # The filename of the file cited.
            sig { returns(String) }
            attr_accessor :filename

            # The index of the file in the list of files.
            sig { returns(Integer) }
            attr_accessor :index

            # The type of the file citation. Always `file_citation`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A citation to a file.
            sig do
              params(
                file_id: String,
                filename: String,
                index: Integer,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The ID of the file.
              file_id:,
              # The filename of the file cited.
              filename:,
              # The index of the file in the list of files.
              index:,
              # The type of the file citation. Always `file_citation`.
              type: :file_citation
            )
            end

            sig do
              override.returns(
                {
                  file_id: String,
                  filename: String,
                  index: Integer,
                  type: Symbol
                }
              )
            end
            def to_hash
            end
          end

          class URLCitation < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::URLCitation,
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

          class ContainerFileCitation < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::ContainerFileCitation,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the container file.
            sig { returns(String) }
            attr_accessor :container_id

            # The index of the last character of the container file citation in the message.
            sig { returns(Integer) }
            attr_accessor :end_index

            # The ID of the file.
            sig { returns(String) }
            attr_accessor :file_id

            # The filename of the container file cited.
            sig { returns(String) }
            attr_accessor :filename

            # The index of the first character of the container file citation in the message.
            sig { returns(Integer) }
            attr_accessor :start_index

            # The type of the container file citation. Always `container_file_citation`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A citation for a container file used to generate a model response.
            sig do
              params(
                container_id: String,
                end_index: Integer,
                file_id: String,
                filename: String,
                start_index: Integer,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The ID of the container file.
              container_id:,
              # The index of the last character of the container file citation in the message.
              end_index:,
              # The ID of the file.
              file_id:,
              # The filename of the container file cited.
              filename:,
              # The index of the first character of the container file citation in the message.
              start_index:,
              # The type of the container file citation. Always `container_file_citation`.
              type: :container_file_citation
            )
            end

            sig do
              override.returns(
                {
                  container_id: String,
                  end_index: Integer,
                  file_id: String,
                  filename: String,
                  start_index: Integer,
                  type: Symbol
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
                  OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::FilePath,
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
                OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::Variants
              ]
            )
          end
          def self.variants
          end
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Agent,
                OpenAI::Internal::AnyHash
              )
            end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that owns this multi-agent streaming event.
          sig { params(agent_name: String).returns(T.attached_class) }
          def self.new(
            # The canonical name of the agent that produced this item.
            agent_name:
          )
          end

          sig { override.returns({ agent_name: String }) }
          def to_hash
          end
        end
      end
    end
  end
end
