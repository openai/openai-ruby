# frozen_string_literal: true

require_relative "../../internal/request_options_scope"

module OpenAI
  module Helpers
    module Chat
      # Executes a bounded, non-streaming Chat Completions function-tool loop.
      class ToolRunner
        class Error < StandardError
        end

        class MaxRoundsError < Error
        end

        # @api private
        def initialize(completions:, params:, tool_handlers:, max_rounds:)
          unless max_rounds.is_a?(Integer) && max_rounds.positive?
            raise ArgumentError, "max_rounds must be a positive integer"
          end

          @completions = completions
          @max_rounds = max_rounds
          @params, options = OpenAI::Chat::CompletionCreateParams.dump_request(params)
          @request_options = OpenAI::Internal::RequestOptionsScope.new(options)
          @handlers = tool_handlers.to_h.dup
          validate_options(options)

          # Validate a separate copy: schema conversion must not replace the models
          # used by create to parse the final completion's structured output.
          definitions, = OpenAI::Chat::CompletionCreateParams.dump_request(params)
          completions.get_structured_output_models(definitions)
          names = definitions.fetch(:tools).map do |tool|
            unless tool[:type] == :function || tool[:type] == "function"
              raise ArgumentError, "run_tools supports function tools only"
            end

            name = tool.dig(:function, :name)
            unless name.is_a?(String) && !name.empty? && @handlers[name].respond_to?(:call)
              raise ArgumentError, "Each function tool must have a named callable in tool_handlers"
            end

            name
          end

          unless names.uniq.length == names.length && @handlers.keys.sort == names.sort
            raise ArgumentError, "Tool definitions and tool_handlers must have matching, unique string names"
          end

          @allowed_names = allowed_tool_names(names)
          @seen = {}
          @params.fetch(:messages).each do |message|
            Array(message[:tool_calls]).each { |call| @seen[call[:id]] = true }
          end
        end

        # @api private
        def run
          @max_rounds.times do |round|
            completion = create_completion(round)
            unless completion.choices.length == 1
              raise Error, "run_tools requires exactly one completion choice"
            end

            choice = completion.choices.first
            message = choice.message
            raise Error, "Expected an assistant message" unless message.role == :assistant

            calls = message.tool_calls || []
            if choice.finish_reason == :stop && calls.empty? && message.function_call.nil?
              return completion
            end

            unless [:stop, :tool_calls].include?(choice.finish_reason) && !calls.empty? && message.function_call.nil?
              raise Error, "Completion did not finish normally or provide complete function tool calls"
            end

            if round + 1 == @max_rounds
              raise MaxRoundsError, "Tool runner reached max_rounds before a final completion"
            end

            # Prepare the entire batch before allowing any callback side effects.
            prepared = calls.map { |call| prepare(call) }
            assistant = message.to_h.slice(:role, :content, :refusal)
            assistant[:tool_calls] = prepared.map { |call, _handler, _arguments| call }
            assistant[:audio] = {id: message.audio.id} if message.audio
            @params[:messages] << assistant
            prepared.each do |call, handler, arguments|
              output = handler.call(arguments)
              content = output.is_a?(String) ? output.dup : JSON.generate(output)
              @params[:messages] << {role: :tool, tool_call_id: call[:id], content: content}
            end

            # A forced tool choice applies to the first round; allow a final answer.
            # Preserve the caller's allowed-tools restriction, when supplied.
            choice = @params[:tool_choice]
            @params[:tool_choice] = if choice.is_a?(Hash) && choice[:type].to_s == "allowed_tools"
              choice.merge(allowed_tools: choice.fetch(:allowed_tools).merge(mode: :auto))
            else
              :auto
            end
          end
        end

        private

        def create_completion(round)
          @completions.create(
            @params.merge(request_options: @request_options.child("chat.tool_runner.round.#{round}"))
          )
        rescue KeyError, NoMethodError, TypeError, OpenAI::Errors::ConversionError
          # The create parser may reject malformed function payloads before the
          # runner can inspect them. Keep this rescue outside callback execution.
          raise Error, "Malformed Chat Completion response", cause: nil
        end

        def allowed_tool_names(names)
          choice = @params[:tool_choice]
          return names unless choice.is_a?(Hash) && (choice[:type] || choice["type"]).to_s == "allowed_tools"

          choice = OpenAI::Chat::ChatCompletionAllowedToolChoice.dump(choice, state: {can_retry: true})
          @params[:tool_choice] = choice
          allowed = choice[:allowed_tools]
          unless allowed.is_a?(Hash) && allowed[:tools].is_a?(Array)
            raise ArgumentError, "allowed_tools must include a tools array"
          end

          allowed[:tools].map do |tool|
            type = tool[:type] || tool["type"] if tool.is_a?(Hash)
            function = tool[:function] || tool["function"] if tool.is_a?(Hash)
            name = function[:name] || function["name"] if function.is_a?(Hash)
            unless type.to_s == "function" && names.include?(name)
              raise ArgumentError, "allowed_tools must reference registered function tools"
            end

            name
          end
        end

        def validate_options(options)
          unless @params[:n].nil? || @params[:n] == 1
            raise ArgumentError, "run_tools supports n: 1 only"
          end

          if @params[:stream] || @params[:functions] || @params[:function_call]
            raise ArgumentError, "run_tools requires non-streaming function tools"
          end

          controlled = %w[messages tools tool_choice n stream functions function_call]
          if options[:extra_body]&.keys&.any? { |key| controlled.include?(key.to_s) }
            raise ArgumentError, "extra_body cannot override tool runner control parameters"
          end

          unless @params[:messages].is_a?(Array) && @params[:tools].is_a?(Array)
            raise ArgumentError, "messages and tools must be arrays"
          end

          unless @handlers.keys.all? { |name| name.is_a?(String) }
            raise ArgumentError, "tool_handlers keys must be strings"
          end
        end

        def prepare(call)
          unless call.is_a?(OpenAI::Chat::ChatCompletionMessageFunctionToolCall) &&
              call.id.is_a?(String) &&
              !call.id.empty? &&
              !@seen.key?(call.id)
            raise Error, "Expected a function tool call with a new, nonempty ID"
          end

          function = call.function
          unless function.is_a?(OpenAI::Chat::ChatCompletionMessageFunctionToolCall::Function)
            raise Error, "Expected a function tool payload"
          end

          handler = @handlers[function.name]
          raise Error, "Model requested an unregistered function tool" unless handler
          unless @allowed_names.include?(function.name)
            raise Error, "Model requested a function tool that is not allowed"
          end

          arguments = begin
            JSON.parse(function.arguments)
          rescue JSON::ParserError, TypeError
            raise Error, "Function arguments must be a valid JSON object", cause: nil
          end

          raise Error, "Function arguments must be a JSON object" unless arguments.is_a?(Hash)

          @seen[call.id] = true
          wire_call = {
            id: call.id,
            type: :function,
            function: {name: function.name, arguments: function.arguments}
          }
          [wire_call, handler, arguments]
        rescue OpenAI::Errors::ConversionError
          raise Error, "Malformed function tool payload", cause: nil
        end
      end
    end
  end
end
