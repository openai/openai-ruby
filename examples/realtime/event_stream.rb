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
      end
    end
  end
end
