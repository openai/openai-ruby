# frozen_string_literal: true

module OpenAI
  module Realtime
    module ConnectionResources
      class Base
        # @api private
        def initialize(connection)
          @connection = connection
        end

        private def compact_event(event) = event.compact

        private def event_payload(params, *metadata_keys)
          payload = params.to_h.dup
          metadata = metadata_keys.to_h do |key|
            value = payload.key?(key) ? payload.delete(key) : payload.delete(key.to_s)
            [key, value]
          end

          [payload, metadata]
        end
      end

      class Session < Base
        def update(**params)
          session, metadata = event_payload(params, :event_id)
          @connection.send_event(
            compact_event(type: :"session.update", session: session, **metadata)
          )
        end
      end

      class Response < Base
        def create(**params)
          response, metadata = event_payload(params, :event_id)
          @connection.send_event(
            compact_event(
              type: :"response.create",
              response: response.empty? ? nil : response,
              **metadata
            )
          )
        end

        def cancel(response_id: nil, event_id: nil)
          @connection.send_event(
            compact_event(type: :"response.cancel", response_id: response_id, event_id: event_id)
          )
        end
      end

      class Conversation < Base
        # @return [OpenAI::Realtime::ConnectionResources::ConversationItems]
        attr_reader :items

        # @api private
        def initialize(connection)
          super
          @items = ConversationItems.new(connection)
        end
      end

      class ConversationItems < Base
        def create(**params)
          item, metadata = event_payload(params, :event_id, :previous_item_id)
          @connection.send_event(
            compact_event(type: :"conversation.item.create", item: item, **metadata)
          )
        end

        def delete(item_id:, event_id: nil)
          @connection.send_event(
            compact_event(type: :"conversation.item.delete", item_id: item_id, event_id: event_id)
          )
        end

        def retrieve(item_id:, event_id: nil)
          @connection.send_event(
            compact_event(type: :"conversation.item.retrieve", item_id: item_id, event_id: event_id)
          )
        end
      end
    end
  end
end
