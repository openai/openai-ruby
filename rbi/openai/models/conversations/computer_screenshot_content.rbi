# typed: strong

module OpenAI
  module Models
    module Conversations
      class ComputerScreenshotContent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::ComputerScreenshotContent,
              OpenAI::Internal::AnyHash
            )
          end

        # The detail level of the screenshot image to be sent to the model. One of `high`,
        # `low`, `auto`, or `original`. Defaults to `auto`.
        sig do
          returns(
            OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol
          )
        end
        attr_accessor :detail

        # The identifier of an uploaded file that contains the screenshot.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_id

        # The URL of the screenshot image.
        sig { returns(T.nilable(String)) }
        attr_accessor :image_url

        # Specifies the event type. For a computer screenshot, this property is always set
        # to `computer_screenshot`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A screenshot of a computer.
        sig do
          params(
            detail:
              OpenAI::Conversations::ComputerScreenshotContent::Detail::OrSymbol,
            file_id: T.nilable(String),
            image_url: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The detail level of the screenshot image to be sent to the model. One of `high`,
          # `low`, `auto`, or `original`. Defaults to `auto`.
          detail:,
          # The identifier of an uploaded file that contains the screenshot.
          file_id:,
          # The URL of the screenshot image.
          image_url:,
          # Specifies the event type. For a computer screenshot, this property is always set
          # to `computer_screenshot`.
          type: :computer_screenshot
        )
        end

        sig do
          override.returns(
            {
              detail:
                OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol,
              file_id: T.nilable(String),
              image_url: T.nilable(String),
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # The detail level of the screenshot image to be sent to the model. One of `high`,
        # `low`, `auto`, or `original`. Defaults to `auto`.
        module Detail
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Conversations::ComputerScreenshotContent::Detail
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LOW =
            T.let(
              :low,
              OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol
            )
          HIGH =
            T.let(
              :high,
              OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol
            )
          AUTO =
            T.let(
              :auto,
              OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol
            )
          ORIGINAL =
            T.let(
              :original,
              OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Conversations::ComputerScreenshotContent::Detail::TaggedSymbol
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
