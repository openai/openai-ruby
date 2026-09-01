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
          event_params = params.reject { |key, _value| key == :type || key == "type" }
          @connection.send_event(**event_params, type: :"response.create")
        end
      end
    end
  end
end
