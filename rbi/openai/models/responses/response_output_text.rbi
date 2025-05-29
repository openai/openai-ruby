# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputText < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseOutputText,
              OpenAI::Internal::AnyHash
            )
          end

        # The annotations of the text output.
        sig do
          returns(
            T::Array[
              T.any(
                OpenAI::Responses::ResponseOutputText::Annotation::FileCitation,
                OpenAI::Responses::ResponseOutputText::Annotation::URLCitation,
                OpenAI::Responses::ResponseOutputText::Annotation::FilePath
              )
            ]
          )
        end
        attr_accessor :annotations

        # The text output from the model.
        sig { returns(String) }
        attr_accessor :text

        # The parsed contents of the output, if JSON schema is specified.
        sig { returns(T.anything) }
        attr_accessor :parsed

        # The type of the output text. Always `output_text`.
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          returns(
            T.nilable(T::Array[OpenAI::Responses::ResponseOutputText::Logprob])
          )
        end
        attr_reader :logprobs

        sig do
          params(
            logprobs:
              T::Array[OpenAI::Responses::ResponseOutputText::Logprob::OrHash]
          ).void
        end
        attr_writer :logprobs

        # A text output from the model.
        sig do
          params(
            annotations:
              T::Array[
                T.any(
                  OpenAI::Responses::ResponseOutputText::Annotation::FileCitation::OrHash,
                  OpenAI::Responses::ResponseOutputText::Annotation::URLCitation::OrHash,
                  OpenAI::Responses::ResponseOutputText::Annotation::FilePath::OrHash
                )
              ],
            text: String,
            logprobs:
              T::Array[OpenAI::Responses::ResponseOutputText::Logprob::OrHash],
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The annotations of the text output.
          annotations:,
          # The text output from the model.
          text:,
          logprobs: nil,
          # The type of the output text. Always `output_text`.
          type: :output_text
        )
        end

        sig do
          override.returns(
            {
              annotations:
                T::Array[
                  T.any(
                    OpenAI::Responses::ResponseOutputText::Annotation::FileCitation,
                    OpenAI::Responses::ResponseOutputText::Annotation::URLCitation,
                    OpenAI::Responses::ResponseOutputText::Annotation::FilePath
                  )
                ],
              text: String,
              type: Symbol,
              logprobs: T::Array[OpenAI::Responses::ResponseOutputText::Logprob]
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
                OpenAI::Responses::ResponseOutputText::Annotation::FileCitation,
                OpenAI::Responses::ResponseOutputText::Annotation::URLCitation,
                OpenAI::Responses::ResponseOutputText::Annotation::FilePath
              )
            end

          class FileCitation < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseOutputText::Annotation::FileCitation,
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
                  OpenAI::Responses::ResponseOutputText::Annotation::URLCitation,
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
                  OpenAI::Responses::ResponseOutputText::Annotation::FilePath,
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
                OpenAI::Responses::ResponseOutputText::Annotation::Variants
              ]
            )
          end
          def self.variants
          end
        end

        class Logprob < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseOutputText::Logprob,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(String) }
          attr_accessor :token

          sig { returns(T::Array[Integer]) }
          attr_accessor :bytes

          sig { returns(Float) }
          attr_accessor :logprob

          sig do
            returns(
              T::Array[
                OpenAI::Responses::ResponseOutputText::Logprob::TopLogprob
              ]
            )
          end
          attr_accessor :top_logprobs

          # The log probability of a token.
          sig do
            params(
              token: String,
              bytes: T::Array[Integer],
              logprob: Float,
              top_logprobs:
                T::Array[
                  OpenAI::Responses::ResponseOutputText::Logprob::TopLogprob::OrHash
                ]
            ).returns(T.attached_class)
          end
          def self.new(token:, bytes:, logprob:, top_logprobs:)
          end

          sig do
            override.returns(
              {
                token: String,
                bytes: T::Array[Integer],
                logprob: Float,
                top_logprobs:
                  T::Array[
                    OpenAI::Responses::ResponseOutputText::Logprob::TopLogprob
                  ]
              }
            )
          end
          def to_hash
          end

          class TopLogprob < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Responses::ResponseOutputText::Logprob::TopLogprob,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :token

            sig { returns(T::Array[Integer]) }
            attr_accessor :bytes

            sig { returns(Float) }
            attr_accessor :logprob

            # The top log probability of a token.
            sig do
              params(
                token: String,
                bytes: T::Array[Integer],
                logprob: Float
              ).returns(T.attached_class)
            end
            def self.new(token:, bytes:, logprob:)
            end

            sig do
              override.returns(
                { token: String, bytes: T::Array[Integer], logprob: Float }
              )
            end
            def to_hash
            end
          end
        end
      end
    end
  end
end
