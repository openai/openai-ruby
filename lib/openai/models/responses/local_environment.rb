# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class LocalEnvironment < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   Use a local computer environment.
        #
        #   @return [Symbol, :local]
        required :type, const: :local

        # @!attribute skills
        #   An optional list of skills.
        #
        #   @return [Array<OpenAI::Models::Responses::LocalSkill>, nil]
        optional :skills, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::LocalSkill] }

        # @!method initialize(skills: nil, type: :local)
        #   @param skills [Array<OpenAI::Models::Responses::LocalSkill>] An optional list of skills.
        #
        #   @param type [Symbol, :local] Use a local computer environment.
      end
    end
  end
end
