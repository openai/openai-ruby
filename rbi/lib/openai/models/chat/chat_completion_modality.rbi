# typed: strong

module OpenAI
  module Models
    ChatCompletionModality = T.type_alias { Chat::ChatCompletionModality }

    module Chat
      class ChatCompletionModality < OpenAI::Enum
        abstract!

        TEXT = :text
        AUDIO = :audio

        class << self
          sig { override.returns(T::Array[Symbol]) }
          def values
          end
        end
      end
    end
  end
end
