# frozen_string_literal: true

require_relative "events"

module OpenAI
  module Helpers
    module Streaming
      class ResponseStream
        include OpenAI::Internal::Type::BaseStream

        def initialize(raw_stream:, text_format: nil, starting_after: nil)
          @text_format = text_format
          @starting_after = starting_after
          @raw_stream = raw_stream
          @iterator = iterator
          @state = ResponseStreamState.new(
            text_format: text_format
          )
        end

        def until_done
          each {} # rubocop:disable Lint/EmptyBlock
          self
        end

        def text
          OpenAI::Internal::Util.chain_fused(@iterator) do |yielder|
            @iterator.each do |event|
              case event
              when OpenAI::Streaming::ResponseTextDeltaEvent
                yielder << event.delta
              end
            end
          end
        end

        def get_final_response
          until_done
          response = @state.completed_response
          raise RuntimeError.new("Didn't receive a 'response.completed' event") unless response
          response
        end

        def get_output_text
          response = get_final_response
          text_parts = []

          response.output.each do |output|
            next unless output.type == :message

            output.content.each do |content|
              next unless content.type == :output_text
              text_parts << content.text
            end
          end

          text_parts.join
        end

        private

        def iterator
          @iterator ||= OpenAI::Internal::Util.chain_fused(@raw_stream) do |y|
            @raw_stream.each do |raw_event|
              events_to_yield = @state.handle_event(raw_event)
              events_to_yield.each do |event|
                if @starting_after.nil? || event.sequence_number > @starting_after
                  y << event
                end
              end
            end
          end
        end
      end

      class ResponseStreamState
        attr_reader :completed_response

        def initialize(text_format:)
          @current_snapshot = nil
          @completed_response = nil
          @text_format = text_format
        end

        def handle_event(event)
          @current_snapshot = accumulate_event(
            event: event,
            current_snapshot: @current_snapshot
          )

          events_to_yield = []

          case event
          when OpenAI::Models::Responses::ResponseTextDeltaEvent
            output = @current_snapshot.output[event.output_index]
            assert_type(output, :message)

            content = output.content[event.content_index]
            assert_type(content, :output_text)

            events_to_yield << OpenAI::Streaming::ResponseTextDeltaEvent.new(
              content_index: event.content_index,
              delta: event.delta,
              item_id: event.item_id,
              output_index: event.output_index,
              sequence_number: event.sequence_number,
              type: event.type,
              snapshot: content.text
            )

          when OpenAI::Models::Responses::ResponseTextDoneEvent
            output = @current_snapshot.output[event.output_index]
            assert_type(output, :message)

            content = output.content[event.content_index]
            assert_type(content, :output_text)

            parsed = parse_structured_text(content.text)

            events_to_yield << OpenAI::Streaming::ResponseTextDoneEvent.new(
              content_index: event.content_index,
              item_id: event.item_id,
              output_index: event.output_index,
              sequence_number: event.sequence_number,
              text: event.text,
              type: event.type,
              parsed: parsed
            )

          when OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent
            output = @current_snapshot.output[event.output_index]
            assert_type(output, :function_call)

            events_to_yield << OpenAI::Streaming::ResponseFunctionCallArgumentsDeltaEvent.new(
              delta: event.delta,
              item_id: event.item_id,
              output_index: event.output_index,
              sequence_number: event.sequence_number,
              type: event.type,
              snapshot: output.arguments
            )

          when OpenAI::Models::Responses::ResponseCompletedEvent
            events_to_yield << OpenAI::Streaming::ResponseCompletedEvent.new(
              sequence_number: event.sequence_number,
              type: event.type,
              response: event.response
            )

          else
            # Pass through other events unchanged.
            events_to_yield << event
          end

          events_to_yield
        end

        def accumulate_event(event:, current_snapshot:)
          if current_snapshot.nil?
            unless event.is_a?(OpenAI::Models::Responses::ResponseCreatedEvent)
              raise "Expected first event to be response.created"
            end

            # Use the converter to create a new, isolated copy of the response object.
            # This ensures proper type validation and prevents shared object references.
            return OpenAI::Internal::Type::Converter.coerce(
              OpenAI::Models::Responses::Response,
              event.response
            )
          end

          case event
          when OpenAI::Models::Responses::ResponseOutputItemAddedEvent
            current_snapshot.output.push(event.item)

          when OpenAI::Models::Responses::ResponseContentPartAddedEvent
            output = current_snapshot.output[event.output_index]
            if output && output.type == :message
              output.content.push(event.part)
              current_snapshot.output[event.output_index] = output
            end

          when OpenAI::Models::Responses::ResponseTextDeltaEvent
            output = current_snapshot.output[event.output_index]
            if output && output.type == :message
              content = output.content[event.content_index]
              if content && content.type == :output_text
                content.text += event.delta
                output.content[event.content_index] = content
                current_snapshot.output[event.output_index] = output
              end
            end

          when OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent
            output = current_snapshot.output[event.output_index]
            if output && output.type == :function_call
              output.arguments = (output.arguments || "") + event.delta
              current_snapshot.output[event.output_index] = output
            end

          when OpenAI::Models::Responses::ResponseCompletedEvent
            @completed_response = event.response
          end

          current_snapshot
        end

        private

        def assert_type(object, expected_type)
          return if object && object.type == expected_type
          actual_type = object ? object.type : "nil"
          raise "Invalid state: expected #{expected_type} but got #{actual_type}"
        end

        def parse_structured_text(text)
          return nil unless @text_format && text

          begin
            parsed = JSON.parse(text, symbolize_names: true)
            OpenAI::Internal::Type::Converter.coerce(@text_format, parsed)
          rescue JSON::ParserError => e
            raise RuntimeError.new(
              "Failed to parse structured text as JSON for #{@text_format}: #{e.message}. " \
              "Raw text: #{text.inspect}"
            )
          end
        end
      end
    end
  end
end
