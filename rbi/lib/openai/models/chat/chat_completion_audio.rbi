# typed: strong

module OpenAI
  module Models
    ChatCompletionAudio = T.type_alias { Chat::ChatCompletionAudio }

    module Chat
      class ChatCompletionAudio < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { returns(String) }
        def data
        end

        sig { params(_: String).returns(String) }
        def data=(_)
        end

        sig { returns(Integer) }
        def expires_at
        end

        sig { params(_: Integer).returns(Integer) }
        def expires_at=(_)
        end

        sig { returns(String) }
        def transcript
        end

        sig { params(_: String).returns(String) }
        def transcript=(_)
        end

        sig do
          params(id: String, data: String, expires_at: Integer, transcript: String).returns(T.attached_class)
        end
        def self.new(id:, data:, expires_at:, transcript:)
        end

        sig { override.returns({id: String, data: String, expires_at: Integer, transcript: String}) }
        def to_hash
        end
      end
    end
  end
end
