# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionMessage
        # Concatenate output-text blocks in message order, without fetching or
        # filtering by phase. Reading this method does not change serialization.
        # @return [String]
        def output_text
          content
            .filter_map do |part|
              (part[:text] || part["text"]) if (part[:type] || part["type"]).to_s == "output_text"
            end
            .join
        end
      end
    end
  end
end
