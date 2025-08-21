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

        sig do
          params(
            file_id: T.nilable(String),
            image_url: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
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
              file_id: T.nilable(String),
              image_url: T.nilable(String),
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
