# typed: strong

module OpenAI
  module Models
    module Realtime
      RealtimeToolsConfig =
        T.let(
          OpenAI::Internal::Type::ArrayOf[
            union: OpenAI::Realtime::RealtimeToolsConfigUnion
          ],
          OpenAI::Internal::Type::Converter
        )
    end
  end
end
