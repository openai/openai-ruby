# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCallOutputScreenshot < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # Specifies the event type. For a computer screenshot, this property is always set
        # to `computer_screenshot`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The identifier of an uploaded file that contains the screenshot.
        sig { returns(T.nilable(String)) }
        attr_reader :file_id

        sig { params(file_id: String).void }
        attr_writer :file_id

        # The URL of the screenshot image.
        sig { returns(T.nilable(String)) }
        attr_reader :image_url

        sig { params(image_url: String).void }
        attr_writer :image_url

        # A computer screenshot image used with the computer use tool.
        sig do
          params(file_id: String, image_url: String, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # The identifier of an uploaded file that contains the screenshot.
          file_id: nil,
          # The URL of the screenshot image.
          image_url: nil,
          # Specifies the event type. For a computer screenshot, this property is always set
          # to `computer_screenshot`.
          type: :computer_screenshot
        )
        end

        sig do
          override.returns({ type: Symbol, file_id: String, image_url: String })
        end
        def to_hash
        end
      end
    end
  end
end
