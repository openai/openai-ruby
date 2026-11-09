# frozen_string_literal: true

module OpenAI
  module Helpers
    # Helpers for the structured output API.
    #
    # see https://platform.openai.com/docs/guides/structured-outputs
    # see https://json-schema.org
    #
    # Based on the DSL in {OpenAI::Internal::Type}, but currently only support the limited subset of JSON schema types used in structured output APIs.
    #
    # Supported types: {NilClass} {String} {Symbol} {Integer} {Float} {OpenAI::Boolean}, {OpenAI::EnumOf}, {OpenAI::UnionOf}, {OpenAI::ArrayOf}, {OpenAI::BaseModel}
    module StructuredOutput
      # Carries a visible format update's local parser without adding a wire field.
      # A nil model means the update explicitly cleared typed parsing.
      # @api private
      module RequestWithFormatUpdate
        attr_accessor :text_model
      end

      private_constant :RequestWithFormatUpdate

      # Convert schemas in input items after the SDK has copied the request or event.
      #
      # @api private
      def self.prepare_configuration_updates!(request)
        input = request[:input] || request["input"]
        items = request[:items] || request["items"]
        if input.is_a?(Array)
          input.each do |item|
            prepare_configuration_update!(item) do |model|
              request.extend(RequestWithFormatUpdate) unless request.is_a?(RequestWithFormatUpdate)
              request.text_model = model
            end
          end
        end

        items.each { |item| prepare_configuration_update!(item) } if items.is_a?(Array)
        prepare_configuration_update!(request[:item] || request["item"])
        request
      end

      def self.prepare_configuration_update!(item)
        return unless item.is_a?(Hash)
        type = item[:type] || item["type"]
        return unless type == :configuration_update || type == "configuration_update"

        text = item[:text] || item["text"]
        return unless text.is_a?(Hash)
        unless text.key?(:format) || text.key?("format")
          key = text.key?(:format_) ? :format_ : "format_"
          text[:format] = text.delete(key) if text.key?(key)
        end

        format = text[:format] || text["format"]
        return unless format.is_a?(Hash)
        type = format[:type] || format["type"]
        model = nil
        if type == :json_schema || type == "json_schema"
          key = format.key?(:schema) ? :schema : "schema"
          schema = format[key]
          if schema.is_a?(JsonSchemaConverter)
            model = schema
            format[key] = JsonSchemaConverter.to_json_schema(schema)
          end
        end

        yield model if block_given?
      end

      private_class_method :prepare_configuration_update!
    end
  end
end
