# frozen_string_literal: true

module OpenAI
  module Helpers
    module Streaming
      class ChatCompletionStream
        include OpenAI::Internal::Type::BaseStream

        def initialize(raw_stream:, response_format: nil, input_tools: nil)
          @raw_stream = raw_stream
          @state = ChatCompletionStreamState.new(
            response_format: response_format,
            input_tools: input_tools
          )
          @iterator = iterator
        end

        def get_final_completion
          until_done
          @state.get_final_completion
        end

        def get_output_text
          completion = get_final_completion
          text_parts = []

          completion.choices.each do |choice|
            next unless choice.message.content
            text_parts << choice.message.content
          end

          text_parts.join
        end

        def until_done
          each {} # rubocop:disable Lint/EmptyBlock
          self
        end

        def current_completion_snapshot
          @state.current_completion_snapshot
        end

        def text
          OpenAI::Internal::Util.chain_fused(@iterator) do |yielder|
            @iterator.each do |event|
              yielder << event.delta if event.is_a?(ChatContentDeltaEvent)
            end
          end
        end

        private

        def iterator
          @iterator ||= OpenAI::Internal::Util.chain_fused(@raw_stream) do |y|
            @raw_stream.each do |raw_event|
              next unless valid_chat_completion_chunk?(raw_event)
              @state.handle_chunk(raw_event).each do |event|
                y << event
              end
            end
          end
        end

        def valid_chat_completion_chunk?(sse_event)
          # Although the _raw_stream is always supposed to contain only objects adhering to ChatCompletionChunk schema,
          # this is broken by the Azure OpenAI in case of Asynchronous Filter enabled.
          # An easy filter is to check for the "object" property:
          # - should be "chat.completion.chunk" for a ChatCompletionChunk;
          # - is an empty string for Asynchronous Filter events.
          sse_event.object == :"chat.completion.chunk"
        end
      end

      class ChatCompletionStreamState
        attr_reader :current_completion_snapshot

        def initialize(response_format: nil, input_tools: nil)
          @current_completion_snapshot = nil
          @choice_event_states = []
          @input_tools = Array(input_tools)
          @response_format = response_format
          @rich_response_format = response_format.is_a?(Class) ? response_format : nil
        end

        def get_final_completion
          parse_chat_completion(
            chat_completion: current_completion_snapshot,
            response_format: @rich_response_format
          )
        end

        # Transforms raw streaming chunks into higher-level events that represent content changes,
        # tool calls, and completion states. It maintains a running snapshot of the complete
        # response by accumulating data from each chunk.
        #
        # The method performs the following steps:
        #   1. Unwraps the chunk if it's wrapped in a ChatChunkEvent
        #   2. Filters out non-ChatCompletionChunk objects
        #   3. Accumulates the chunk data into the current completion snapshot
        #   4. Generates appropriate events based on the chunk's content
        def handle_chunk(chunk)
          chunk = chunk.chunk if chunk.is_a?(ChatChunkEvent)

          return [] unless chunk.is_a?(OpenAI::Chat::ChatCompletionChunk)

          @current_completion_snapshot = accumulate_chunk(chunk)
          build_events(chunk: chunk, completion_snapshot: @current_completion_snapshot)
        end

        private

        def get_choice_state(choice)
          index = choice.index
          @choice_event_states[index] ||= ChoiceEventState.new(input_tools: @input_tools)
        end

        def accumulate_chunk(chunk)
          if @current_completion_snapshot.nil?
            return convert_initial_chunk_into_snapshot(chunk)
          end

          completion_snapshot = @current_completion_snapshot

          chunk.choices.each do |choice|
            accumulate_choice!(choice, completion_snapshot)
          end

          completion_snapshot.usage = chunk.usage if chunk.usage
          completion_snapshot.system_fingerprint = chunk.system_fingerprint if chunk.system_fingerprint

          completion_snapshot
        end

        def accumulate_choice!(choice, completion_snapshot)
          choice_snapshot = completion_snapshot.choices[choice.index]

          if choice_snapshot.nil?
            choice_snapshot = create_new_choice_snapshot(choice)
            completion_snapshot.choices[choice.index] = choice_snapshot
          else
            update_existing_choice_snapshot(choice, choice_snapshot)
          end

          if choice.finish_reason
            choice_snapshot.finish_reason = choice.finish_reason
            handle_finish_reason(choice.finish_reason)
          end

          parse_tool_calls!(choice.delta.tool_calls, choice_snapshot.message.tool_calls)

          accumulate_logprobs!(choice.logprobs, choice_snapshot)
        end

        def create_new_choice_snapshot(choice)
          OpenAI::Internal::Type::Converter.coerce(
            OpenAI::Models::Chat::ParsedChoice,
            choice.to_h.except(:delta).merge(message: choice.delta.to_h)
          )
        end

        def update_existing_choice_snapshot(choice, choice_snapshot)
          delta_data = model_dump(choice.delta)
          message_hash = model_dump(choice_snapshot.message)

          accumulated_data = accumulate_delta(message_hash, delta_data)

          choice_snapshot.message = OpenAI::Internal::Type::Converter.coerce(
            OpenAI::Chat::ChatCompletionMessage,
            accumulated_data
          )
        end

        def build_events(chunk:, completion_snapshot:)
          chunk_event = ChatChunkEvent.new(
            type: :chunk,
            chunk: chunk,
            snapshot: completion_snapshot
          )

          choice_events = chunk.choices.flat_map do |choice|
            build_choice_events(choice, completion_snapshot)
          end

          [chunk_event] + choice_events
        end

        def build_choice_events(choice, completion_snapshot)
          choice_state = get_choice_state(choice)
          choice_snapshot = completion_snapshot.choices[choice.index]

          content_delta_events(choice, choice_snapshot) +
            tool_call_delta_events(choice, choice_snapshot) +
            logprobs_delta_events(choice, choice_snapshot) +
            choice_state.get_done_events(
              choice_chunk: choice,
              choice_snapshot: choice_snapshot,
              response_format: @response_format
            )
        end

        def content_delta_events(choice, choice_snapshot)
          events = []

          if choice.delta.content && choice_snapshot.message.content
            events << ChatContentDeltaEvent.new(
              type: :"content.delta",
              delta: choice.delta.content,
              snapshot: choice_snapshot.message.content,
              parsed: choice_snapshot.message.parsed
            )
          end

          if choice.delta.refusal && choice_snapshot.message.refusal
            events << ChatRefusalDeltaEvent.new(
              type: :"refusal.delta",
              delta: choice.delta.refusal,
              snapshot: choice_snapshot.message.refusal
            )
          end

          events
        end

        def tool_call_delta_events(choice, choice_snapshot)
          events = []
          return events unless choice.delta.tool_calls

          tool_calls = choice_snapshot.message.tool_calls
          return events unless tool_calls

          choice.delta.tool_calls.each do |tool_call_delta|
            tool_call = tool_calls[tool_call_delta.index]
            next unless tool_call.type == :function && tool_call_delta.function

            parsed_args = if tool_call.function.respond_to?(:parsed)
              tool_call.function.parsed
            end
            events << ChatFunctionToolCallArgumentsDeltaEvent.new(
              type: :"tool_calls.function.arguments.delta",
              name: tool_call.function.name,
              index: tool_call_delta.index,
              arguments: tool_call.function.arguments,
              parsed: parsed_args,
              arguments_delta: tool_call_delta.function.arguments || ""
            )
          end

          events
        end

        def logprobs_delta_events(choice, choice_snapshot)
          events = []
          return events unless choice.logprobs && choice_snapshot.logprobs

          if choice.logprobs.content && choice_snapshot.logprobs.content
            events << ChatLogprobsContentDeltaEvent.new(
              type: :"logprobs.content.delta",
              content: choice.logprobs.content,
              snapshot: choice_snapshot.logprobs.content
            )
          end

          if choice.logprobs.refusal && choice_snapshot.logprobs.refusal
            events << ChatLogprobsRefusalDeltaEvent.new(
              type: :"logprobs.refusal.delta",
              refusal: choice.logprobs.refusal,
              snapshot: choice_snapshot.logprobs.refusal
            )
          end

          events
        end

        def handle_finish_reason(finish_reason)
          return unless parseable_input?

          case finish_reason
          when :length
            raise LengthFinishReasonError.new(completion: @chat_completion)
          when :content_filter
            raise ContentFilterFinishReasonError.new
          end
        end

        def parse_tool_calls!(delta_tool_calls, snapshot_tool_calls)
          return unless delta_tool_calls && snapshot_tool_calls

          delta_tool_calls.each do |tool_call_chunk|
            tool_call_snapshot = snapshot_tool_calls[tool_call_chunk.index]
            next unless tool_call_snapshot&.type == :function

            input_tool = find_input_tool(tool_call_snapshot.function.name)
            next unless input_tool&.dig(:function, :strict)
            next unless tool_call_snapshot.function.arguments

            begin
              tool_call_snapshot.function.parsed = JSON.parse(
                tool_call_snapshot.function.arguments,
                symbolize_names: true
              )
            rescue JSON::ParserError
              nil
            end
          end
        end

        def accumulate_logprobs!(choice_logprobs, choice_snapshot)
          return unless choice_logprobs

          if choice_snapshot.logprobs.nil?
            choice_snapshot.logprobs = OpenAI::Chat::ChatCompletionChunk::Choice::Logprobs.new(
              content: choice_logprobs.content,
              refusal: choice_logprobs.refusal
            )
          else
            if choice_logprobs.content
              choice_snapshot.logprobs.content ||= []
              choice_snapshot.logprobs.content.concat(choice_logprobs.content)
            end

            if choice_logprobs.refusal
              choice_snapshot.logprobs.refusal ||= []
              choice_snapshot.logprobs.refusal.concat(choice_logprobs.refusal)
            end
          end
        end

        def parse_chat_completion(chat_completion:, response_format:)
          choices = chat_completion.choices.map do |choice|
            if parseable_input?
              case choice.finish_reason
              when :length
                raise LengthFinishReasonError.new(completion: chat_completion)
              when :content_filter
                raise ContentFilterFinishReasonError.new
              end
            end

            build_parsed_choice(choice, response_format)
          end

          OpenAI::Internal::Type::Converter.coerce(
            OpenAI::Chat::ParsedChatCompletion,
            chat_completion.to_h.merge(choices: choices)
          )
        end

        def build_parsed_choice(choice, response_format)
          message = choice.message

          tool_calls = parse_choice_tool_calls(message.tool_calls)

          choice_data = model_dump(choice)
          choice_data[:message] = model_dump(message)
          choice_data[:message][:tool_calls] = tool_calls && !tool_calls.empty? ? tool_calls : nil

          if response_format && message.content && !message.refusal
            choice_data[:message][:parsed] = parse_content(response_format, message)
          end

          choice_data
        end

        def parse_choice_tool_calls(tool_calls)
          return unless tool_calls

          tool_calls.map do |tool_call|
            tool_call_hash = model_dump(tool_call)
            next tool_call_hash unless tool_call_hash[:type] == :function && tool_call_hash[:function]

            function = tool_call_hash[:function]
            parsed_args = parse_function_tool_arguments(function)
            function[:parsed] = parsed_args if parsed_args

            tool_call_hash
          end
        end

        def parseable_input?
          @response_format || @input_tools.any?
        end

        def model_dump(obj)
          if obj.is_a?(OpenAI::Internal::Type::BaseModel)
            obj.deep_to_h
          elsif obj.respond_to?(:to_h)
            obj.to_h
          else
            obj
          end
        end

        def find_input_tool(name)
          @input_tools.find { |tool| tool.dig(:function, :name) == name }
        end

        def parse_function_tool_arguments(function)
          return nil unless function[:arguments]

          input_tool = find_input_tool(function[:name])
          return nil unless input_tool&.dig(:function, :strict)

          parsed = JSON.parse(function[:arguments], symbolize_names: true)
          return nil unless parsed

          model_class = input_tool[:model] || input_tool.dig(:function, :parameters)
          if model_class.is_a?(Class)
            OpenAI::Internal::Type::Converter.coerce(model_class, parsed)
          else
            parsed
          end
        rescue JSON::ParserError
          nil
        end

        def parse_content(response_format, message)
          return nil unless message.content && !message.refusal

          parsed = JSON.parse(message.content, symbolize_names: true)
          return nil unless parsed

          if response_format.is_a?(Class)
            OpenAI::Internal::Type::Converter.coerce(response_format, parsed)
          else
            parsed
          end
        rescue JSON::ParserError
          nil
        end

        def convert_initial_chunk_into_snapshot(chunk)
          data = chunk.to_h

          choices = []
          chunk.choices.each do |choice|
            choice_hash = choice.to_h
            delta_hash = choice.delta.to_h

            message_data = delta_hash.dup
            message_data[:role] ||= :assistant

            choice_data = {
              index: choice_hash[:index],
              message: message_data,
              finish_reason: choice_hash[:finish_reason],
              logprobs: choice_hash[:logprobs]
            }
            choices << choice_data
          end

          OpenAI::Internal::Type::Converter.coerce(
            OpenAI::Chat::ParsedChatCompletion,
            {
              id: data[:id],
              object: :"chat.completion",
              created: data[:created],
              model: data[:model],
              choices: choices,
              usage: data[:usage],
              system_fingerprint: nil,
              service_tier: data[:service_tier]
            }
          )
        end

        def accumulate_delta(acc, delta)
          return acc if delta.nil?

          delta.each do |key, delta_value| # rubocop:disable Metrics/BlockLength
            key = key.to_sym if key.is_a?(String)

            unless acc.key?(key)
              acc[key] = delta_value
              next
            end

            acc_value = acc[key]
            if acc_value.nil?
              acc[key] = delta_value
              next
            end

            # Special properties that should be replaced, not accumulated.
            if [:index, :type, :parsed].include?(key)
              acc[key] = delta_value
              next
            end

            if acc_value.is_a?(String) && delta_value.is_a?(String)
              acc[key] = acc_value + delta_value
            elsif acc_value.is_a?(Numeric) && delta_value.is_a?(Numeric) # rubocop:disable Lint/DuplicateBranch
              acc[key] = acc_value + delta_value
            elsif acc_value.is_a?(Hash) && delta_value.is_a?(Hash)
              acc[key] = accumulate_delta(acc_value, delta_value)
            elsif acc_value.is_a?(Array) && delta_value.is_a?(Array)
              if acc_value.all? { |x| x.is_a?(String) || x.is_a?(Numeric) }
                acc_value.concat(delta_value)
                next
              end

              delta_value.each do |delta_entry|
                unless delta_entry.is_a?(Hash)
                  raise TypeError,
                        "Unexpected list delta entry is not a hash: #{delta_entry}"
                end

                index = delta_entry[:index] || delta_entry["index"]
                if index.nil?
                  raise RuntimeError,
                        "Expected list delta entry to have an `index` key; #{delta_entry}"
                end
                unless index.is_a?(Integer)
                  raise TypeError,
                        "Unexpected, list delta entry `index` value is not an integer; #{index}"
                end

                if acc_value[index].nil?
                  acc_value[index] = delta_entry
                elsif acc_value[index].is_a?(Hash)
                  acc_value[index] = accumulate_delta(acc_value[index], delta_entry)
                end
              end
            else
              acc[key] = acc_value
            end
          end

          acc
        end
      end

      class ChoiceEventState
        def initialize(input_tools:)
          @input_tools = Array(input_tools)
          @content_done = false
          @refusal_done = false
          @logprobs_content_done = false
          @logprobs_refusal_done = false
          @done_tool_calls = Set.new
          @current_tool_call_index = nil
        end

        def get_done_events(choice_chunk:, choice_snapshot:, response_format:)
          events = []

          if choice_snapshot.finish_reason
            events.concat(content_done_events(choice_snapshot, response_format))

            if @current_tool_call_index && !@done_tool_calls.include?(@current_tool_call_index)
              event = tool_done_event(choice_snapshot, @current_tool_call_index)
              events << event if event
            end
          end

          Array(choice_chunk.delta.tool_calls).each do |tool_call|
            if @current_tool_call_index != tool_call.index
              events.concat(content_done_events(choice_snapshot, response_format))

              if @current_tool_call_index
                event = tool_done_event(choice_snapshot, @current_tool_call_index)
                events << event if event
              end
            end

            @current_tool_call_index = tool_call.index
          end

          events
        end

        private

        def content_done_events(choice_snapshot, response_format)
          events = []

          if choice_snapshot.message.content && !@content_done
            @content_done = true
            parsed = parse_content(choice_snapshot.message, response_format)
            choice_snapshot.message.parsed = parsed

            events << ChatContentDoneEvent.new(
              type: :"content.done",
              content: choice_snapshot.message.content,
              parsed: parsed
            )
          end

          if choice_snapshot.message.refusal && !@refusal_done
            @refusal_done = true
            events << ChatRefusalDoneEvent.new(
              type: :"refusal.done",
              refusal: choice_snapshot.message.refusal
            )
          end

          events + logprobs_done_events(choice_snapshot)
        end

        def logprobs_done_events(choice_snapshot)
          events = []
          logprobs = choice_snapshot.logprobs
          return events unless logprobs

          if logprobs.content&.any? && !@logprobs_content_done
            @logprobs_content_done = true
            events << ChatLogprobsContentDoneEvent.new(
              type: :"logprobs.content.done",
              content: logprobs.content
            )
          end

          if logprobs.refusal&.any? && !@logprobs_refusal_done
            @logprobs_refusal_done = true
            events << ChatLogprobsRefusalDoneEvent.new(
              type: :"logprobs.refusal.done",
              refusal: logprobs.refusal
            )
          end

          events
        end

        def tool_done_event(choice_snapshot, tool_index)
          return nil if @done_tool_calls.include?(tool_index)

          @done_tool_calls.add(tool_index)

          tool_call = choice_snapshot.message.tool_calls&.[](tool_index)
          return nil unless tool_call&.type == :function

          parsed_args = parse_function_tool_arguments(tool_call.function)

          if tool_call.function.respond_to?(:parsed=)
            tool_call.function.parsed = parsed_args
          end

          ChatFunctionToolCallArgumentsDoneEvent.new(
            type: :"tool_calls.function.arguments.done",
            index: tool_index,
            name: tool_call.function.name,
            arguments: tool_call.function.arguments,
            parsed: parsed_args
          )
        end

        def parse_content(message, response_format)
          return nil unless response_format && message.content

          parsed = JSON.parse(message.content, symbolize_names: true)
          if response_format.is_a?(Class)
            OpenAI::Internal::Type::Converter.coerce(response_format, parsed)
          else
            parsed
          end
        rescue JSON::ParserError
          nil
        end

        def parse_function_tool_arguments(function)
          return nil unless function.arguments

          tool = find_input_tool(function.name)
          return nil unless tool&.dig(:function, :strict)

          parsed = JSON.parse(function.arguments, symbolize_names: true)

          if tool[:model]
            OpenAI::Internal::Type::Converter.coerce(tool[:model], parsed)
          else
            parsed
          end
        rescue JSON::ParserError
          nil
        end

        def find_input_tool(name)
          @input_tools.find { |tool| tool.dig(:function, :name) == name }
        end
      end
    end
  end
end
