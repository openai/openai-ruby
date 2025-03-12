# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageDeleteParams < OpenAI::BaseModel
          # @!parse
          #   extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

          # @!attribute thread_id
          #
          #   @return [String]
          required :thread_id, String

          # @!parse
          #   # @param thread_id [String]
          #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          #   #
          #   def initialize(thread_id:, request_options: {}, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end
  end
end
