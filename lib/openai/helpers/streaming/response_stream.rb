# frozen_string_literal: true

module OpenAI
  module Helpers
    module Streaming
      class ResponseStream
        include OpenAI::Internal::Type::BaseStream

        def initialize(raw_stream:, text_format: nil, starting_after: nil)
          @text_format = text_format
          @starting_after = starting_after
          @raw_stream = raw_stream
          @last_response = raw_stream.last_response
          @iterator = iterator
          @state = ResponseStreamState.new(
            text_format: text_format,
            starting_after: starting_after
          )
        end

        def until_done
          text.each { |_delta| nil }
          self
        end

        def text
          OpenAI::Internal::Util.chain_fused(@iterator) do |yielder|
            @text_only = true
            @iterator.each do |event|
              # Restore normal event snapshots while caller code is running.
              @text_only = false
              case event
              when OpenAI::Models::Responses::ResponseTextDeltaEvent
                yielder << event.delta
              end

              @text_only = true
            end

          ensure
            @text_only = false
          end
        end

        def get_final_response
          until_done
          response = @state.completed_response
          raise "Didn't receive a 'response.completed' event" unless response
          response
        end

        def get_output_text = get_final_response.output_text

        private

        def iterator
          @iterator ||= OpenAI::Internal::Util.chain_fused(@raw_stream) do |y|
            @raw_stream.each do |raw_event|
              events_to_yield = @state.handle_event(raw_event, text_only: @text_only == true)
              events_to_yield.each do |event|
                y << event if after_starting_event?(event)
              end
            end
          end
        end

        def after_starting_event?(event)
          return true if @starting_after.nil?
          return true if event.is_a?(UnknownStreamEvent) && event.sequence_number.nil?

          event.sequence_number > @starting_after
        end
      end

      class ResponseStreamState
        attr_reader :completed_response

        def initialize(text_format:, starting_after: nil)
          @current_snapshot = nil
          @completed_response = nil
          @text_format = text_format
          @resumed = !starting_after.nil?
          @unexposed_buffers = {}.compare_by_identity
        end

        def handle_event(event, text_only: false)
          return [event] if event.is_a?(UnknownStreamEvent)

          @current_snapshot = accumulate_event(
            event: event,
            current_snapshot: @current_snapshot
          )

          events_to_yield = []

          case event
          when OpenAI::Models::Responses::ResponseTextDeltaEvent
            return [event] if text_only

            snapshot = nil
            if @current_snapshot
              output = @current_snapshot.output[event.output_index]
              if output.is_a?(OpenAI::Models::Responses::ResponseOutputMessage)
                content = output.content[event.content_index]
                snapshot = content.text if content.is_a?(OpenAI::Models::Responses::ResponseOutputText)
              end
            end

            @unexposed_buffers.delete(snapshot)

            # A server-directed resumed stream or an unknown future snapshot value
            # has no complete prefix from which to build a truthful snapshot.
            events_to_yield <<
              OpenAI::Streaming::ResponseTextDeltaEvent.new(event.to_h.merge(snapshot: snapshot))

          when OpenAI::Models::Responses::ResponseTextDoneEvent
            text = if @current_snapshot
              output = @current_snapshot.output[event.output_index]
              if output.is_a?(OpenAI::Models::Responses::ResponseOutputMessage)
                content = output.content[event.content_index]
                content.text if content.is_a?(OpenAI::Models::Responses::ResponseOutputText)
              end
            else
              event.text
            end

            parsed = parse_structured_text(text)

            events_to_yield <<
              OpenAI::Streaming::ResponseTextDoneEvent.new(
                content_index: event.content_index,
                item_id: event.item_id,
                output_index: event.output_index,
                sequence_number: event.sequence_number,
                text: event.text,
                type: event.type,
                **event.to_h.slice(:logprobs),
                parsed: parsed
              )

          when OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent
            return [event] if text_only

            snapshot = nil
            if @current_snapshot
              output = @current_snapshot.output[event.output_index]
              if output.is_a?(OpenAI::Models::Responses::ResponseFunctionToolCall)
                snapshot = output.arguments
              end
            end

            @unexposed_buffers.delete(snapshot)

            # See the text-delta branch above: a partial server resume or an
            # unknown future output item has no truthful accumulated prefix.
            events_to_yield <<
              OpenAI::Streaming::ResponseFunctionCallArgumentsDeltaEvent.new(
                event.to_h.merge(snapshot: snapshot)
              )

          when OpenAI::Models::Responses::ResponseCompletedEvent
            events_to_yield <<
              OpenAI::Streaming::ResponseCompletedEvent.new(
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
            if event.is_a?(OpenAI::Models::Responses::ResponseCreatedEvent)
              return isolated_value(event.response)
            end

            unless @resumed
              raise "Expected first event to be response.created"
            end

            if event.is_a?(OpenAI::Models::Responses::ResponseCompletedEvent)
              @completed_response = event.response
              return event.response
            end

            return nil
          end

          if event.is_a?(OpenAI::Models::Responses::ResponseCompletedEvent)
            @completed_response = event.response
          else
            accumulate_output(event, current_snapshot.output)
          end

          current_snapshot
        end

        # @api private
        def accumulate_output(event, items)
          case event
          when OpenAI::Models::Responses::ResponseOutputItemAddedEvent
            items.push(isolated_value(event.item))

          when OpenAI::Models::Responses::ResponseContentPartAddedEvent
            output = items[event.output_index]
            if output.is_a?(OpenAI::Models::Responses::ResponseOutputMessage)
              output.content.push(isolated_value(event.part))
              items[event.output_index] = output
            end

          when OpenAI::Models::Responses::ResponseTextDeltaEvent
            output = items[event.output_index]
            if output.is_a?(OpenAI::Models::Responses::ResponseOutputMessage)
              content = output.content[event.content_index]
              if content.is_a?(OpenAI::Models::Responses::ResponseOutputText)
                content.text = append_delta(content.text, event.delta)
                output.content[event.content_index] = content
                items[event.output_index] = output
              end
            end

          when OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent
            output = items[event.output_index]
            if output.is_a?(OpenAI::Models::Responses::ResponseFunctionToolCall)
              output.arguments = append_delta(output.arguments || "", event.delta)
              items[event.output_index] = output
            end
          end

          nil
        end

        private

        # Reuse a buffer only until it becomes a caller-visible snapshot. The
        # first append also isolates strings belonging to incoming wire events.
        def append_delta(value, delta)
          return value << delta if @unexposed_buffers.key?(value)

          buffer = value + delta
          @unexposed_buffers[buffer] = true
          buffer
        end

        # Materialize fresh containers before snapshot accumulation mutates them.
        # Coercing an already-typed model returns it unchanged, so first use the
        # model's recursive raw representation. Unknown union fallbacks stay raw.
        def isolated_value(value)
          raw = OpenAI::Internal::Type::BaseModel.recursively_to_h(value, convert: false)
          return raw unless value.is_a?(OpenAI::Internal::Type::BaseModel)

          OpenAI::Internal::Type::Converter.coerce(value.class, raw)
        end

        def parse_structured_text(text)
          return nil unless @text_format && text

          begin
            parsed = JSON.parse(text, symbolize_names: true)
            OpenAI::Internal::Type::Converter.coerce(@text_format, parsed)
          rescue JSON::ParserError
            raise(
              "Failed to parse structured text as JSON for #{@text_format}",
              cause: nil
            )
          end
        end
      end
    end
  end
end

module OpenAI
  module Resources
    class Responses
      # Creates or resumes a streaming response and parses structured outputs.
      # @overload stream(access_programs: nil, **params)
      #   @param access_programs [OpenAI::Models::Responses::ResponseCreateParams::AccessPrograms]
      #     Domain-specific access programs to use for this request.
      #   @param params [Hash{Symbol=>Object}] Other response creation or retrieval parameters.
      def stream(params)
        parsed, options = OpenAI::Responses::ResponseCreateParams.dump_request(params)
        starting_after, response_id = parsed.values_at(:starting_after, :response_id)

        if starting_after && !response_id
          raise ArgumentError, "starting_after can only be used with response_id"
        end

        model, tool_models = get_structured_output_models(parsed)

        unwrap = -> (raw) do
          if raw[:type] == "response.completed" && raw[:response]
            parse_structured_outputs!(raw[:response], model, tool_models)
          end

          raw
        end

        if response_id
          retrieve_params = parsed.slice(:include, :starting_after)
          retrieve_params[:request_options] = options

          raw_stream = retrieve_streaming_internal(
            response_id,
            params: retrieve_params,
            unwrap: unwrap
          )
        else
          parsed[:stream] = true

          raw_stream = @client.request(
            method: :post,
            path: "responses",
            headers: {"accept" => "text/event-stream"},
            body: parsed,
            stream: OpenAI::Internal::Stream,
            model: OpenAI::Models::Responses::ResponseStreamEvent,
            unwrap: unwrap,
            security: {bearer_auth: true},
            options: options
          )
        end

        OpenAI::Streaming::ResponseStream.new(
          raw_stream: raw_stream,
          text_format: model,
          starting_after: starting_after
        )
      end

      private def retrieve_streaming_internal(response_id, params:, unwrap:)
        parsed, options = OpenAI::Responses::ResponseRetrieveParams.dump_request(params)
        parsed.store(:stream, true)
        @client.request(
          method: :get,
          path: ["responses/%1$s", response_id],
          query: parsed,
          headers: {"accept" => "text/event-stream"},
          stream: OpenAI::Internal::Stream,
          model: OpenAI::Responses::ResponseStreamEvent,
          security: {bearer_auth: true},
          options: options,
          unwrap: unwrap
        )
      end
    end
  end
end
