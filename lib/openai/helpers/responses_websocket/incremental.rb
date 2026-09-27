# frozen_string_literal: true

module OpenAI
  module Responses
    # Optional, caller-fed provisional output for one WebSocket lane.
    # Feed the events returned by lane.receive; use a separate instance per lane.
    # This helper never reads, closes, or writes to a connection. Tools are data.
    #
    # Output is provisional and may be unavailable when the wire omitted its
    # scaffolding, or a known output update cannot be represented. Terminal events
    # are retained exactly as received, never filled from provisional output.
    # Call reset to discard all retained state.
    class IncrementalResponse
      attr_reader :phase

      def initialize
        reset
      end

      # A detached provisional output snapshot, or nil when unavailable/terminal.
      def output
        @output&.map { |item| copy(item) }
      end

      # The exact consumed completion, failure, incomplete, or error event.
      def terminal_event
        @terminal_event && copy(@terminal_event)
      end

      def reset
        @state = OpenAI::Helpers::Streaming::ResponseStreamState.new(text_format: nil)
        @phase = nil
        @output = nil
        @terminal_event = nil
        nil
      end

      def add(event)
        case event
        when OpenAI::Responses::UnknownServerEvent
          return
        when
            OpenAI::Responses::ResponseCompletedEvent,
            OpenAI::Responses::ResponseFailedEvent,
            OpenAI::Responses::ResponseIncompleteEvent,
            OpenAI::Responses::ResponsesServerEvent::ResponseWsError
          reset
          @terminal_event = copy(event)
          @phase = :terminal
        when OpenAI::Responses::ResponseCreatedEvent
          response = copy(event)[:response]
          unless response.is_a?(OpenAI::Responses::Response) &&
              (response[:output].nil? || response[:output].is_a?(Array))
            raise SessionError, "Invalid Responses WebSocket created response."
          end

          reset
          @output = response[:output] || []
          @phase = :provisional
        when
            OpenAI::Responses::ResponseOutputItemAddedEvent,
            OpenAI::Responses::ResponseOutputItemDoneEvent,
            OpenAI::Responses::ResponseContentPartAddedEvent,
            OpenAI::Responses::ResponseContentPartDoneEvent,
            OpenAI::Responses::ResponseTextDeltaEvent,
            OpenAI::Responses::ResponseTextDoneEvent,
            OpenAI::Responses::ResponseFunctionCallArgumentsDeltaEvent,
            OpenAI::Responses::ResponseFunctionCallArgumentsDoneEvent,
            OpenAI::Responses::ResponseCustomToolCallInputDeltaEvent,
            OpenAI::Responses::ResponseCustomToolCallInputDoneEvent,
            OpenAI::Responses::ResponseRefusalDeltaEvent,
            OpenAI::Responses::ResponseRefusalDoneEvent,
            OpenAI::Responses::ResponseOutputTextAnnotationAddedEvent
          return if @phase == :unavailable || @phase == :terminal

          apply_output(copy(event))
        else
          # A full output snapshot must not leave stale fields after unsupported
          # indexed updates. Unknown raw events and progress events are not output.
          if @phase != :terminal &&
              event.class.known_fields.key?(:output_index) &&
              event[:type].to_s.end_with?(".added", ".delta", ".done")
            unavailable
          end
        end

        nil
      end

      private

      def apply_output(event)
        index = event[:output_index]
        unless @output && index.is_a?(Integer) && index >= 0 && index <= @output.length
          return unavailable
        end

        case event
        when OpenAI::Responses::ResponseOutputItemDoneEvent
          # Replace the entire item: done may reduce its content or change its ID.
          @output[index] = event.item
          @state = OpenAI::Helpers::Streaming::ResponseStreamState.new(text_format: nil)
        when OpenAI::Responses::ResponseOutputItemAddedEvent
          return unavailable unless index == @output.length

          @state.accumulate_output(event, @output)
        when OpenAI::Responses::ResponseFunctionCallArgumentsDoneEvent
          item = @output[index]
          unless item.is_a?(OpenAI::Responses::ResponseFunctionToolCall) &&
              item.id == event.item_id &&
              event[:arguments].is_a?(String)
            return unavailable
          end

          item.arguments = event[:arguments]
        when
            OpenAI::Responses::ResponseCustomToolCallInputDeltaEvent,
            OpenAI::Responses::ResponseCustomToolCallInputDoneEvent
          item = @output[index]
          unless item.is_a?(OpenAI::Responses::ResponseCustomToolCall) && item.id == event.item_id
            return unavailable
          end

          if event.is_a?(OpenAI::Responses::ResponseCustomToolCallInputDeltaEvent)
            return unavailable unless item[:input].is_a?(String) && event[:delta].is_a?(String)

            item.input << event[:delta]
          else
            return unavailable unless event[:input].is_a?(String)

            item.input = event[:input]
          end
        else
          item = @output[index]
          if event.is_a?(OpenAI::Responses::ResponseFunctionCallArgumentsDeltaEvent)
            unless item.is_a?(OpenAI::Responses::ResponseFunctionToolCall) &&
                item.id == event.item_id &&
                event.delta.is_a?(String)
              return unavailable
            end
          else
            part_index = event[:content_index]
            unless item.is_a?(OpenAI::Responses::ResponseOutputMessage) &&
                item.id == event.item_id &&
                item.content.is_a?(Array) &&
                part_index.is_a?(Integer) &&
                part_index >= 0 &&
                part_index <= item.content.length
              return unavailable
            end

            case event
            when OpenAI::Responses::ResponseContentPartDoneEvent
              item.content[part_index] = event.part
              return
            when OpenAI::Responses::ResponseContentPartAddedEvent
              return unavailable unless part_index == item.content.length
            when OpenAI::Responses::ResponseTextDoneEvent
              part = item.content[part_index]
              unless part.is_a?(OpenAI::Responses::ResponseOutputText) && event[:text].is_a?(String)
                return unavailable
              end

              part.text = event[:text]
              return
            when OpenAI::Responses::ResponseTextDeltaEvent
              part = item.content[part_index]
              unless part.is_a?(OpenAI::Responses::ResponseOutputText) &&
                  part.text.is_a?(String) &&
                  event.delta.is_a?(String)
                return unavailable
              end

            when OpenAI::Responses::ResponseRefusalDeltaEvent, OpenAI::Responses::ResponseRefusalDoneEvent
              part = item.content[part_index]
              return unavailable unless part.is_a?(OpenAI::Responses::ResponseOutputRefusal)

              if event.is_a?(OpenAI::Responses::ResponseRefusalDeltaEvent)
                return unavailable unless part[:refusal].is_a?(String) && event[:delta].is_a?(String)

                part.refusal << event[:delta]
              else
                return unavailable unless event[:refusal].is_a?(String)

                part.refusal = event[:refusal]
              end

              return
            when OpenAI::Responses::ResponseOutputTextAnnotationAddedEvent
              part = item.content[part_index]
              annotation_index = event[:annotation_index]
              unless part.is_a?(OpenAI::Responses::ResponseOutputText) &&
                  part[:annotations].is_a?(Array) &&
                  annotation_index.is_a?(Integer) &&
                  annotation_index >= 0 &&
                  annotation_index <= part[:annotations].length &&
                  (event[:annotation].is_a?(OpenAI::Internal::Type::BaseModel) || event[:annotation].is_a?(Hash))
                return unavailable
              end

              # The event and output use distinct annotation union types.
              # Snapshot copying reconstructs this value as an output annotation.
              part[:annotations][annotation_index] = event[:annotation]
              return
            end
          end

          @state.accumulate_output(event, @output)
        end
      end

      def unavailable
        reset
        @phase = :unavailable
        nil
      end

      # BaseModel's recursive representation copies containers but retains string
      # references. Returned snapshots and incoming events must not share strings.
      def copy(value)
        data = OpenAI::Internal::Type::BaseModel.recursively_to_h(value, convert: false)
        data = JSON.parse(JSON.generate(data), symbolize_names: true)
        return data unless value.is_a?(OpenAI::Internal::Type::BaseModel)

        OpenAI::Internal::Type::Converter.coerce(value.class, data)
      end
    end
  end
end
