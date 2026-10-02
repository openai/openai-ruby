# frozen_string_literal: true

module OpenAI
  module Helpers
    module Beta
      module Agents
        # Shared native model checks; JSON and wire-schema policies stay with each caller.
        # @api private
        module ModelAdapter
          def self.validate!(model, parameter:)
            unless model.is_a?(Class) && model < OpenAI::BaseModel
              raise ArgumentError, "#{parameter} must be an OpenAI::BaseModel subclass"
            end
          end

          def self.coerce(model, value, memoize: false)
            state = OpenAI::Internal::Type::Converter.new_coerce_state(memoize: memoize)
            parsed = OpenAI::Internal::Type::Converter.coerce(model, value, state: state)
            parsed if parsed.is_a?(model) && state[:exactness][:no].zero?
          end
        end

        private_constant :ModelAdapter
      end
    end
  end
end
