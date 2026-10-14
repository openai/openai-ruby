# frozen_string_literal: true

require_relative "../../../models/responses/response"

module OpenAI
  module Models
    module Responses
      class Response
        # Convenience property that aggregates all `output_text` items from the `output` list.
        #
        # If no `output_text` content blocks exist, then an empty string is returned.
        #
        # @return [String]
        def output_text
          texts = []

          output.each do |item|
            next unless item.is_a?(OpenAI::Models::Responses::ResponseOutputMessage)

            item.content.each do |content|
              next unless content.is_a?(OpenAI::Models::Responses::ResponseOutputText)

              texts << content.text
            end
          end

          texts.join
        end
      end
    end
  end
end
