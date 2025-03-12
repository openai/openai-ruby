# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseTextConfig < OpenAI::BaseModel
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig,
                OpenAI::Models::ResponseFormatJSONObject
              )
            )
          )
        end
        def format_
        end

        sig do
          params(
            _: T.any(
              OpenAI::Models::ResponseFormatText,
              OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig,
              OpenAI::Models::ResponseFormatJSONObject
            )
          )
            .returns(
              T.any(
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig,
                OpenAI::Models::ResponseFormatJSONObject
              )
            )
        end
        def format_=(_)
        end

        sig do
          params(
            format_: T.any(
              OpenAI::Models::ResponseFormatText,
              OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig,
              OpenAI::Models::ResponseFormatJSONObject
            )
          )
            .returns(T.attached_class)
        end
        def self.new(format_: nil)
        end

        sig do
          override
            .returns(
              {
                format_: T.any(
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::Responses::ResponseFormatTextJSONSchemaConfig,
                  OpenAI::Models::ResponseFormatJSONObject
                )
              }
            )
        end
        def to_hash
        end
      end
    end
  end
end
