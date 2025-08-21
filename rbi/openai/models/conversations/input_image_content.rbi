# typed: strong

module OpenAI
  module Models
    module Conversations
      class InputImageContent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::InputImageContent,
              OpenAI::Internal::AnyHash
            )
          end

        # The detail level of the image to be sent to the model. One of `high`, `low`, or
        # `auto`. Defaults to `auto`.
        sig do
          returns(
            OpenAI::Conversations::InputImageContent::Detail::TaggedSymbol
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

        # The type of the input item. Always `input_image`.
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(
            detail: OpenAI::Conversations::InputImageContent::Detail::OrSymbol,
            file_id: T.nilable(String),
            image_url: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The detail level of the image to be sent to the model. One of `high`, `low`, or
          # `auto`. Defaults to `auto`.
          detail:,
          # The ID of the file to be sent to the model.
          file_id:,
          # The URL of the image to be sent to the model. A fully qualified URL or base64
          # encoded image in a data URL.
          image_url:,
          # The type of the input item. Always `input_image`.
          type: :input_image
        )
        end

        sig do
          override.returns(
            {
              detail:
                OpenAI::Conversations::InputImageContent::Detail::TaggedSymbol,
              file_id: T.nilable(String),
              image_url: T.nilable(String),
              type: Symbol
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
              T.all(Symbol, OpenAI::Conversations::InputImageContent::Detail)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LOW =
            T.let(
              :low,
              OpenAI::Conversations::InputImageContent::Detail::TaggedSymbol
            )
          HIGH =
            T.let(
              :high,
              OpenAI::Conversations::InputImageContent::Detail::TaggedSymbol
            )
          AUTO =
            T.let(
              :auto,
              OpenAI::Conversations::InputImageContent::Detail::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Conversations::InputImageContent::Detail::TaggedSymbol
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
