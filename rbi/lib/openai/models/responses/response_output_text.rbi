# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputText < OpenAI::BaseModel
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

        # The text output from the model.
        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        # The type of the output text. Always `output_text`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # A text output from the model.
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

        # A citation to a file.
        class Annotation < OpenAI::Union
          abstract!

          Variants = type_template(:out) do
            {
              fixed: T.any(
                OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation,
                OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation,
                OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath
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
        end
      end
    end
  end
end
