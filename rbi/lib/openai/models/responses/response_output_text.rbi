# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputText < OpenAI::Internal::Type::BaseModel
        # The annotations of the text output.
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
        attr_accessor :annotations

        # The text output from the model.
        sig { returns(String) }
        attr_accessor :text

        # The type of the output text. Always `output_text`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A text output from the model.
        sig do
          params(
            annotations: T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation,
                OpenAI::Internal::AnyHash,
                OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation,
                OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath
              )
            ],
            text: String,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          # The annotations of the text output.
          annotations:,
          # The text output from the model.
          text:,
          # The type of the output text. Always `output_text`.
          type: :output_text
        ); end
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
            def self.new(
              # The ID of the file.
              file_id:,
              # The index of the file in the list of files.
              index:,
              # The type of the file citation. Always `file_citation`.
              type: :file_citation
            ); end
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
            ); end
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
            def self.new(
              # The ID of the file.
              file_id:,
              # The index of the file in the list of files.
              index:,
              # The type of the file path. Always `file_path`.
              type: :file_path
            ); end
            sig { override.returns({file_id: String, index: Integer, type: Symbol}) }
            def to_hash; end
          end

          sig do
            override
              .returns(
                [OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath]
              )
          end
          def self.variants; end
        end
      end
    end
  end
end
