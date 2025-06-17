# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponsePrompt < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::ResponsePrompt, OpenAI::Internal::AnyHash)
          end

        # The unique identifier of the prompt template to use.
        sig { returns(String) }
        attr_accessor :id

        # Optional map of values to substitute in for variables in your prompt. The
        # substitution values can either be strings, or other Response input types like
        # images or files.
        sig do
          returns(
            T.nilable(
              T::Hash[
                Symbol,
                T.any(
                  String,
                  OpenAI::Responses::ResponseInputText,
                  OpenAI::Responses::ResponseInputImage,
                  OpenAI::Responses::ResponseInputFile
                )
              ]
            )
          )
        end
        attr_accessor :variables

        # Optional version of the prompt template.
        sig { returns(T.nilable(String)) }
        attr_accessor :version

        # Reference to a prompt template and its variables.
        # [Learn more](https://platform.openai.com/docs/guides/text?api-mode=responses#reusable-prompts).
        sig do
          params(
            id: String,
            variables:
              T.nilable(
                T::Hash[
                  Symbol,
                  T.any(
                    String,
                    OpenAI::Responses::ResponseInputText::OrHash,
                    OpenAI::Responses::ResponseInputImage::OrHash,
                    OpenAI::Responses::ResponseInputFile::OrHash
                  )
                ]
              ),
            version: T.nilable(String)
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique identifier of the prompt template to use.
          id:,
          # Optional map of values to substitute in for variables in your prompt. The
          # substitution values can either be strings, or other Response input types like
          # images or files.
          variables: nil,
          # Optional version of the prompt template.
          version: nil
        )
        end

        sig do
          override.returns(
            {
              id: String,
              variables:
                T.nilable(
                  T::Hash[
                    Symbol,
                    T.any(
                      String,
                      OpenAI::Responses::ResponseInputText,
                      OpenAI::Responses::ResponseInputImage,
                      OpenAI::Responses::ResponseInputFile
                    )
                  ]
                ),
              version: T.nilable(String)
            }
          )
        end
        def to_hash
        end

        # A text input to the model.
        module Variable
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                OpenAI::Responses::ResponseInputText,
                OpenAI::Responses::ResponseInputImage,
                OpenAI::Responses::ResponseInputFile
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Responses::ResponsePrompt::Variable::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
