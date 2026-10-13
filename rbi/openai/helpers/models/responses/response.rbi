# typed: true
# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class Response < OpenAI::Internal::Type::BaseModel
        # Concatenates text from all output messages.
        sig { returns(String) }
        def output_text
        end
      end
    end
  end
end
