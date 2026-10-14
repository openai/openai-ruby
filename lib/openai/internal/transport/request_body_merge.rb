# frozen_string_literal: true

module OpenAI
  module Internal
    module Transport
      # @api private
      #
      # Reconciles exact string/symbol counterparts while preserving the
      # existing deep-merge behavior for request body overrides.
      module RequestBodyMerge
        class << self
          # @api private
          #
          # @param body [Object, nil]
          # @param extra_body [Object, nil]
          #
          # @return [Object, nil]
          def merge(body, extra_body)
            values = [body, extra_body].compact
            return OpenAI::Internal::Util.deep_merge(*values) unless values.length == 2

            merge_hashes(values.fetch(0), values.fetch(1))
          end

          private

          # @api private
          #
          # @param body [Object]
          # @param extra_body [Object]
          # @param key_source [Object] original body layer used for counterpart lookup
          #
          # @return [Object]
          def merge_hashes(body, extra_body, key_source: body)
            unless body.is_a?(Hash) && extra_body.is_a?(Hash)
              return OpenAI::Internal::Util.deep_merge(body, extra_body)
            end

            merged = body.dup
            wire_keys = {}
            source = key_source.is_a?(Hash) ? key_source : {}
            source.each_key do |key|
              wire_keys[key.to_s] ||= key if key.is_a?(String) || key.is_a?(Symbol)
            end

            extra_body.each do |extra_key, extra_value|
              key = extra_key
              if !merged.key?(extra_key) && (extra_key.is_a?(String) || extra_key.is_a?(Symbol))
                key = wire_keys.fetch(extra_key.to_s, extra_key)
              end

              merged[key] = if merged.key?(key)
                body_value = merged.fetch(key)
                if body_value.is_a?(Hash) && extra_value.is_a?(Hash)
                  source_value = source.fetch(key, nil)
                  merge_hashes(body_value, extra_value, key_source: source_value)
                else
                  extra_value
                end
              else
                extra_value
              end
            end

            merged
          end
        end
      end
    end
  end
end
