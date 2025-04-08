# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        # @see OpenAI::Resources::FineTuning::Checkpoints::Permissions#delete
        class PermissionDeleteParams < OpenAI::Internal::Type::BaseModel
          # @!parse
          #   extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!parse
          #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          #   #
          #   def initialize(request_options: {}, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
        end
      end
    end
  end
end
