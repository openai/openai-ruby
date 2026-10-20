# frozen_string_literal: true

module OpenAI
  module WebSocket
    # Shared helpers for discriminated JSON WebSocket events.
    #
    # @api private
    module Protocol
      # Unknown wire keys must not replace a selected model's renamed Ruby fields.
      private def validate_wire_field_names!(event, payload)
        pending = [[event, payload]]
        until pending.empty?
          value, raw = pending.pop
          case value
          when OpenAI::Internal::Type::BaseModel
            value.class.fields.each do |name, field|
              raise ArgumentError if name != field.fetch(:api_name) && raw.is_a?(Hash) && raw.key?(name)
            end

            value.to_h.each do |name, child|
              field = value.class.fields[name]
              key = field ? field.fetch(:api_name) : name
              pending << [child, raw.is_a?(Hash) ? raw[key] : nil]
            end

          when Hash
            value.each { |name, child| pending << [child, raw.is_a?(Hash) ? raw[name] : nil] }
          when Array
            value.each_with_index { |child, index| pending << [child, raw.is_a?(Array) ? raw[index] : nil] }
          end
        end

        event
      end

      # A merged string-keyed JSON event and symbol-keyed override must not
      # silently change the command or the configuration that is sent.
      private def validate_client_tree!(event, json_only: false)
        visited = {}.compare_by_identity
        pending = [event]
        until pending.empty?
          item = pending.pop
          next if visited.key?(item)
          visited[item] = true
          case item
          when OpenAI::Internal::Type::BaseModel
            raise ArgumentError if json_only
            validate_model_constants!(item)
            pending << item.to_h
          when Hash
            names = {}
            item.each do |key, value|
              raise ArgumentError unless key.is_a?(String) || key.is_a?(Symbol)
              name = key.to_s
              raise ArgumentError if names.key?(name)
              names[name] = true
              pending << value
            end

          when Array
            pending.concat(item)
          when NilClass, TrueClass, FalseClass, String, Integer, Float, Symbol
            next
          else
            raise ArgumentError if json_only
          end
        end
      end

      private def validate_model_constants!(model)
        model.to_h.each do |name, actual|
          key = name.is_a?(String) ? name.to_sym : name
          field = model.class.known_fields[key]
          next unless field
          const = field.fetch(:const)
          next if const == OpenAI::Internal::OMIT
          if const.is_a?(Symbol)
            raise ArgumentError unless (actual.is_a?(String) || actual.is_a?(Symbol)) && actual.to_s == const.to_s
          elsif actual != const
            raise ArgumentError
          end
        end
      end

      private def discriminator_values(union)
        union.variants.to_h do |variant|
          value = variant.fields.fetch(:type).fetch(:const)
          [value.to_s, true]
        end
      end

      private def event_type(event, message:)
        raise ArgumentError, message unless event.is_a?(Hash)
        raise ArgumentError, message if event.key?(:type) && event.key?("type")

        type = event[:type] || event["type"]
        return type if type.is_a?(String) || type.is_a?(Symbol)

        raise ArgumentError, message
      end
    end
  end
end
