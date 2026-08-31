# frozen_string_literal: true

module OpenAI
  module Responses
    module ConnectionResources
      class Response
        # @api private
        def initialize(connection)
          @connection = connection
        end

        # Send a response.create event over this connection.
        #
        # @return [nil]
        def create(**params)
          @connection.send_event(type: :"response.create", **params)
        end
      end
    end
  end
end
