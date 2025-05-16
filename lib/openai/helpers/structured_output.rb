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
    end
  end
end
