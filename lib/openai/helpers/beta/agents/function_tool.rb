# frozen_string_literal: true

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
            unless arguments.is_a?(Class) && arguments < OpenAI::BaseModel
              raise ArgumentError, "arguments must be an OpenAI::BaseModel subclass"
            end

            raise ArgumentError, "a callback is required" unless handler
            raise ArgumentError, "name must be a nonempty string" unless name.is_a?(String) && !name.empty?

            @name = name.dup.freeze
            @arguments = arguments
            @handler = handler
            @definition = {type: :function, name: @name, parameters: arguments.to_json_schema, description: description}
          end

          # Supply this definition in the agent's tools at creation.
          # @return [Hash{Symbol=>Object}]
          def definition = JSON.parse(JSON.generate(@definition), symbolize_names: true)

          # Pass these local bindings to sessions.stream(tool_handlers: ...).
          # @return [Hash{String=>Proc}]
          def handlers = {name => method(:call).to_proc}

          # Parse model arguments and invoke the application callback.
          # @param arguments [Hash{String=>Object}, String]
          # @return [Object]
          def call(arguments)
            values = JSON.parse(arguments.is_a?(String) ? arguments : JSON.generate(arguments), symbolize_names: true)
            state = OpenAI::Internal::Type::Converter.new_coerce_state
            parsed = OpenAI::Internal::Type::Converter.coerce(@arguments, values, state: state)
            unless state[:exactness].values_at(:no, :maybe).all?(&:zero?) && complete?(parsed)
              raise ArgumentError, "Tool arguments do not match the argument model"
            end

            @handler.call(parsed)
          end

          private

          # The SDK parser tolerates absent/unknown fields for forward compatibility.
          # Local application callbacks require the declared fields, including nullable ones.
          def complete?(value)
            case value
            when OpenAI::BaseModel
              fields = value.class.fields
              data = value.to_h
              data.keys.to_set == fields.keys.to_set &&
                fields.all? do |key, field|
                  const = field[:const]
                  (const == OpenAI::Internal::OMIT || data[key] == const) && complete?(data[key])
                end
            when Array
              value.all? { complete?(_1) }
            else
              true
            end
          end
        end
      end
    end
  end
end
