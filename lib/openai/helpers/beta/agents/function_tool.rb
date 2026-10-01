# frozen_string_literal: true

require_relative "model_adapter"

module OpenAI
  module Helpers
    module Beta
      module Agents
        # Beta binding between an application's argument model and local callback.
        class FunctionTool
          # @return [String]
          attr_reader :name

          # @param name [String]
          # @param arguments [Class<OpenAI::BaseModel>]
          # @param description [String]
          # @yieldparam arguments [OpenAI::BaseModel]
          def initialize(name:, arguments:, description: "", &handler)
            ModelAdapter.validate!(arguments, parameter: "arguments")

            raise ArgumentError, "a callback is required" unless handler
            raise ArgumentError, "name must be a nonempty string" unless name.is_a?(String) && !name.empty?

            @name = name.dup.freeze
            @arguments = arguments
            @handler = handler
            @definition = JSON
              .generate(
                type: :function,
                name: @name,
                parameters: arguments.to_json_schema,
                description: description
              )
              .freeze
          end

          # Supply this definition in the agent's tools at creation.
          # @return [Hash{Symbol=>Object}]
          def definition = JSON.parse(@definition, symbolize_names: true)

          # Pass these local bindings to sessions.stream(tool_handlers: ...).
          # @return [Hash{String=>Proc}]
          def handlers = {name => method(:call).to_proc}

          # Parse using the SDK's BaseModel conventions, then invoke the callback.
          # This is not JSON Schema validation; validate application constraints
          # and authorization in the callback before performing side effects.
          # @param arguments [Hash{String=>Object}, String]
          # @return [Object]
          def call(arguments)
            values = JSON.parse(arguments.is_a?(String) ? arguments : JSON.generate(arguments), symbolize_names: true)
            raise ArgumentError, "Tool arguments must be a JSON object" unless values.is_a?(Hash)
            parsed = ModelAdapter.coerce(@arguments, values)
            unless parsed
              raise ArgumentError, "Tool arguments cannot be parsed into the argument model"
            end

            @handler.call(parsed)
          end

        end
      end
    end
  end
end
