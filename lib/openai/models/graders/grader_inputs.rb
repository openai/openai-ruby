# frozen_string_literal: true

module OpenAI
  module Models
    module Graders
      # @type [OpenAI::Internal::Type::Converter]
      GraderInputs = OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Graders::GraderInputItem }]
    end

    # @type [OpenAI::Internal::Type::Converter]
    GraderInputs = Graders::GraderInputs
  end
end
