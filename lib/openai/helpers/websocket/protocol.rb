# frozen_string_literal: true

module OpenAI
  module WebSocket
    # Shared helpers for discriminated JSON WebSocket events.
    #
    # @api private
    module Protocol
      # JSON schemas and extension data do not have a transport-specific depth limit.
      private def parse_json(data) = JSON.parse(data, symbolize_names: true, max_nesting: false)

      private def generate_json(value) = JSON.generate(value, max_nesting: false)

      private def freeze_json(value)
        pending = [value]
        visited = {}.compare_by_identity
        until pending.empty?
          item = pending.pop
          next if visited.key?(item)
          visited[item] = true
          case item
          when Hash
            item.each { |key, val| pending.push(key, val) }
          when Array
            pending.concat(item)
          end

          item.freeze
        end

        value
      end

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
