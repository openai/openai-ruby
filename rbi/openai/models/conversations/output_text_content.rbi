# typed: strong

module OpenAI
  module Models
    module Conversations
      class OutputTextContent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::OutputTextContent,
              OpenAI::Internal::AnyHash
            )
          end

        # The annotations of the text output.
        sig do
          returns(
            T::Array[
              OpenAI::Conversations::OutputTextContent::Annotation::Variants
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

        sig { returns(T.nilable(T::Array[OpenAI::Conversations::LobProb])) }
        attr_reader :logprobs

        sig do
          params(
            logprobs: T::Array[OpenAI::Conversations::LobProb::OrHash]
          ).void
        end
        attr_writer :logprobs

        sig do
          params(
            annotations:
              T::Array[
                T.any(
                  OpenAI::Conversations::FileCitationBody::OrHash,
                  OpenAI::Conversations::URLCitationBody::OrHash,
                  OpenAI::Conversations::ContainerFileCitationBody::OrHash
                )
              ],
            text: String,
            logprobs: T::Array[OpenAI::Conversations::LobProb::OrHash],
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
                  OpenAI::Conversations::OutputTextContent::Annotation::Variants
                ],
              text: String,
              type: Symbol,
              logprobs: T::Array[OpenAI::Conversations::LobProb]
            }
          )
        end
        def to_hash
        end

        module Annotation
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Conversations::FileCitationBody,
                OpenAI::Conversations::URLCitationBody,
                OpenAI::Conversations::ContainerFileCitationBody
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Conversations::OutputTextContent::Annotation::Variants
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
