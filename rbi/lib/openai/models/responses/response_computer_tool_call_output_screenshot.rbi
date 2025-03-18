# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCallOutputScreenshot < OpenAI::BaseModel
        # Specifies the event type. For a computer screenshot, this property is always set
        #   to `computer_screenshot`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # The identifier of an uploaded file that contains the screenshot.
        sig { returns(T.nilable(String)) }
        def file_id
        end

        sig { params(_: String).returns(String) }
        def file_id=(_)
        end

        # The URL of the screenshot image.
        sig { returns(T.nilable(String)) }
        def image_url
        end

        sig { params(_: String).returns(String) }
        def image_url=(_)
        end

        # A computer screenshot image used with the computer use tool.
        sig { params(file_id: String, image_url: String, type: Symbol).returns(T.attached_class) }
        def self.new(file_id: nil, image_url: nil, type: :computer_screenshot)
        end

        sig { override.returns({type: Symbol, file_id: String, image_url: String}) }
        def to_hash
        end
      end
    end
  end
end
