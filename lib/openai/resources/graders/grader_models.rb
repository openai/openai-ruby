# frozen_string_literal: true

module OpenAI
  module Resources
    class Graders
      class GraderModels
        # @api private
        #
        # @param client [OpenAI::Internal::Transport::RequestClient]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
