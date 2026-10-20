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

      private def coerce_event(union, payload, outbound: false)
        state = OpenAI::Internal::Type::Converter.new_coerce_state(request_only: outbound)
        event = OpenAI::Internal::Type::Converter.coerce(union, payload, state: state)
        raise ArgumentError if state[:error] || !state.fetch(:exactness).fetch(:no).zero?
        ancestors = {}.compare_by_identity
        pending = [[event, false]]
        until pending.empty?
          value, exiting = pending.pop
          if exiting
            ancestors.delete(value)
            next
          end

          children = case value
          when OpenAI::Internal::Type::BaseModel
            data = value.to_h
            validate_model_fields!(value)
            value.class.fields.each do |name, field|
              const = field.fetch(:const)
              if field.fetch(:required) &&
                  field.fetch(:mode) != (outbound ? :coerce : :dump) &&
                  (!outbound || const == OpenAI::Internal::OMIT) &&
                  !data.key?(name)
                raise ArgumentError
              end
            end

            data.values
          when Hash
            value.values
          when Array
            value
          else
            next
          end

          raise ArgumentError if ancestors.key?(value)
          ancestors[value] = true
          pending << [value, true]
          children.each { |child| pending << [child, false] }
        end

        event
      end

      private def validate_event_tree!(event, json_only: false, strict_keys: true)
        ancestors = {}.compare_by_identity
        pending = [[event, false]]
        until pending.empty?
          value, exiting = pending.pop
          if exiting
            ancestors.delete(value)
            next
          end

          children = case value
          when OpenAI::Internal::Type::BaseModel
            raise ArgumentError if json_only
            data = value.to_h
            validate_model_fields!(value)
            [data]
          when Hash
            if strict_keys
              keys = {}
              value.each_key do |key|
                raise ArgumentError unless key.is_a?(String) || key.is_a?(Symbol)
                name = key.to_s
                raise ArgumentError if keys.key?(name)
                keys[name] = true
              end
            end

            value.values
          when Array
            value
          when NilClass, TrueClass, FalseClass, String, Integer, Float, Symbol
            next
          else
            raise ArgumentError if json_only
            next
          end

          raise ArgumentError if ancestors.key?(value)
          ancestors[value] = true
          pending << [value, true]
          children.each { |child| pending << [child, false] }
        end
      end

      private def validate_model_fields!(model)
        names = {}
        model.to_h.each do |name, actual|
          key = name.is_a?(String) ? name.to_sym : name
          field = model.class.known_fields[key]
          serialized_name = field ? field.fetch(:api_name).to_s : key.to_s
          raise ArgumentError if names.key?(serialized_name)
          names[serialized_name] = true
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
