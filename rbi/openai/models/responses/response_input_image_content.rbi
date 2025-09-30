# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputImageContent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseInputImageContent,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of the input item. Always `input_image`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The detail level of the image to be sent to the model. One of `high`, `low`, or
        # `auto`. Defaults to `auto`.
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::ResponseInputImageContent::Detail::OrSymbol
            )
          )
        end
        attr_accessor :detail

        # The ID of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_id

        # The URL of the image to be sent to the model. A fully qualified URL or base64
        # encoded image in a data URL.
        sig { returns(T.nilable(String)) }
        attr_accessor :image_url

        # An image input to the model. Learn about
        # [image inputs](https://platform.openai.com/docs/guides/vision)
        sig do
          params(
            detail:
              T.nilable(
                OpenAI::Responses::ResponseInputImageContent::Detail::OrSymbol
              ),
            file_id: T.nilable(String),
            image_url: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The detail level of the image to be sent to the model. One of `high`, `low`, or
          # `auto`. Defaults to `auto`.
          detail: nil,
          # The ID of the file to be sent to the model.
          file_id: nil,
          # The URL of the image to be sent to the model. A fully qualified URL or base64
          # encoded image in a data URL.
          image_url: nil,
          # The type of the input item. Always `input_image`.
          type: :input_image
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              detail:
                T.nilable(
                  OpenAI::Responses::ResponseInputImageContent::Detail::OrSymbol
                ),
              file_id: T.nilable(String),
              image_url: T.nilable(String)
            }
          )
        end
        def to_hash
        end

        # The detail level of the image to be sent to the model. One of `high`, `low`, or
        # `auto`. Defaults to `auto`.
        module Detail
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Responses::ResponseInputImageContent::Detail
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LOW =
            T.let(
              :low,
              OpenAI::Responses::ResponseInputImageContent::Detail::TaggedSymbol
            )
          HIGH =
            T.let(
              :high,
              OpenAI::Responses::ResponseInputImageContent::Detail::TaggedSymbol
            )
          AUTO =
            T.let(
              :auto,
              OpenAI::Responses::ResponseInputImageContent::Detail::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseInputImageContent::Detail::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
