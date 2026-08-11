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
        # Update the session using Ruby-style resource keywords. The helper adds the
        # protocol's nested `session` envelope.
        def update(params)
          session, metadata = event_payload(params, :event_id)
          @connection.send_event(
            compact_event(type: :"session.update", session: session, **metadata)
          )
        end
      end

      class TranscriptionSession < Base
        # A transcription connection already selects its session capability. Add the
        # required wire discriminator so callers only pass transcription fields.
        def update(params)
          session, metadata = event_payload(params, :event_id)
          session.delete(:type)
          session.delete("type")
          session[:type] = :transcription
          @connection.send_event(
            compact_event(type: :"session.update", session: session, **metadata)
          )
        end
      end

      class TranslationSession < Session
        # Gracefully flush and close a translation session.
        def close(event_id: nil)
          @connection.send_event(compact_event(type: :"session.close", event_id: event_id))
        end
      end

      class Response < Base
        # Create a response from resource fields, omitting the optional wire envelope
        # when no response-specific fields are supplied.
        def create(params = {})
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

      class InputAudioBuffer < Base
        def append(audio:, event_id: nil)
          @connection.send_event(
            compact_event(type: :"input_audio_buffer.append", audio: audio, event_id: event_id)
          )
        end

        def append_bytes(bytes, event_id: nil)
          append(audio: Base64.strict_encode64(bytes), event_id: event_id)
        end

        def commit(event_id: nil)
          @connection.send_event(compact_event(type: :"input_audio_buffer.commit", event_id: event_id))
        end

        def clear(event_id: nil)
          @connection.send_event(compact_event(type: :"input_audio_buffer.clear", event_id: event_id))
        end
      end

      class TranslationInputAudioBuffer < Base
        def append(audio:, event_id: nil)
          @connection.send_event(
            compact_event(type: :"session.input_audio_buffer.append", audio: audio, event_id: event_id)
          )
        end

        def append_bytes(bytes, event_id: nil)
          append(audio: Base64.strict_encode64(bytes), event_id: event_id)
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
        # Create an item from resource fields. Event metadata stays at the outer wire
        # level while the remaining fields become the nested item.
        def create(params)
          item, metadata = event_payload(params, :event_id, :previous_item_id)
          @connection.send_event(
            compact_event(
              type: :"conversation.item.create",
              item: item,
              **metadata
            )
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

        def truncate(item_id:, content_index:, audio_end_ms:, event_id: nil)
          @connection.send_event(
            compact_event(
              type: :"conversation.item.truncate",
              item_id: item_id,
              content_index: content_index,
              audio_end_ms: audio_end_ms,
              event_id: event_id
            )
          )
        end

        # Send the output of a locally executed function call back to the model.
        def create_function_call_output(call_id:, output:, id: nil, status: nil, event_id: nil)
          item = compact_event(
            type: :function_call_output,
            call_id: call_id,
            output: output,
            id: id,
            status: status
          )
          create(**item, event_id: event_id)
        end

        # Approve or reject a pending remote MCP tool call.
        def respond_to_mcp_approval(
          approval_request_id:,
          approve:,
          reason: nil,
          id: nil,
          event_id: nil
        )
          item = compact_event(
            type: :mcp_approval_response,
            id: id || "mcpa_#{SecureRandom.hex(12)}",
            approval_request_id: approval_request_id,
            approve: approve,
            reason: reason
          )
          create(**item, event_id: event_id)
        end
      end

      class OutputAudioBuffer < Base
        def clear(event_id: nil)
          @connection.send_event(compact_event(type: :"output_audio_buffer.clear", event_id: event_id))
        end
      end
    end
  end
end
