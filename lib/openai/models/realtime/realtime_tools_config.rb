# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # @type [OpenAI::Internal::Type::Converter]
      RealtimeToolsConfig =
        OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Realtime::RealtimeToolsConfigUnion }]
    end
  end
end
