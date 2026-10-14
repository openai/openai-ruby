# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaLocalEnvironment < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   Use a local computer environment.
        #
        #   @return [Symbol, :local]
        required :type, const: :local

        # @!attribute skills
        #   An optional list of skills.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaLocalSkill>, nil]
        optional :skills, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaLocalSkill] }

        # @!method initialize(skills: nil, type: :local)
        #   @param skills [Array<OpenAI::Models::Beta::BetaLocalSkill>] An optional list of skills.
        #
        #   @param type [Symbol, :local] Use a local computer environment.
      end
    end

    BetaLocalEnvironment = Beta::BetaLocalEnvironment
  end
end
