# frozen_string_literal: true

module OpenAI
  module Helpers
    module StructuredOutput
      # @generic Member
      #
      # @example
      #   example = OpenAI::UnionOf[Float, OpenAI::ArrayOf[Integer]]
      class UnionOf
        include OpenAI::Internal::Type::Union
        include OpenAI::Helpers::StructuredOutput::JsonSchemaConverter

        # @api private
        #
        # @param state [Hash{Symbol=>Object}]
        #
        #   @option state [Hash{Object=>String}] :defs
        #
        #   @option state [Array<String>] :path
        #
        # @return [Hash{Symbol=>Object}]
        def to_json_schema_inner(state:)
          OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.cache_def!(state, type: self) do
            path = state.fetch(:path)
            mergeable_keys = {[:anyOf] => 0, [:type] => 0}
            schemas = variants.to_enum.with_index.map do
              new_state = {**state, path: [*path, "?.#{_2}"]}
              OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_json_schema_inner(
                _1,
                state: new_state
              )
            end

            schemas.each do |schema|
              mergeable_keys.each_key { mergeable_keys[_1] += 1 if schema.keys == _1 }
            end
            mergeable = mergeable_keys.any? { _1.last == schemas.length }
            mergeable ? OpenAI::Internal::Util.deep_merge(*schemas, concat: true) : {anyOf: schemas}
          end
        end

        private_class_method :new

        def self.[](...) = new(...)

        # @param variants [Array<generic<Member>>]
        def initialize(*variants)
          case variants
          in [Symbol => d, Hash => vs]
            discriminator(d)
            vs.each do |k, v|
              v.is_a?(Proc) ? variant(k, v) : variant(k, -> { v })
            end
          else
            variants.each do |v|
              v.is_a?(Proc) ? variant(v) : variant(-> { v })
            end
          end
        end
      end
    end
  end
end
