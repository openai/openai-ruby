# frozen_string_literal: true

module OpenAI
  module Resources
    class Realtime
      class Translations
        class ClientSecrets
          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
          end
        end
      end
    end
  end
end
