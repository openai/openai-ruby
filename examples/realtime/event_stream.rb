# frozen_string_literal: true

module OpenAI
  module Examples
    module Realtime
      module EventStream
        module_function

        def each_until(connection, stop_after: nil, closed_message: nil)
          reached_target = false
          connection.each do |event|
            yield(event)
            reached_target = stop_after == event.type.to_s
            break if reached_target
          end
          return if stop_after.nil? || reached_target

          raise(closed_message || "Realtime connection closed before #{stop_after}")
        end

        def wait_for(connection, event_class, closed_message:)
          while (event = connection.receive)
            raise event.error.message if event.is_a?(OpenAI::Realtime::RealtimeErrorEvent)
            return event if event.is_a?(event_class)
          end

          raise closed_message
        end
      end
    end
  end
end
