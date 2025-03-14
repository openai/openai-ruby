# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseAudioTranscriptDeltaEvent < OpenAI::BaseModel
        # The partial transcript of the audio response.
        sig { returns(String) }
        def delta
        end

        sig { params(_: String).returns(String) }
        def delta=(_)
        end

        # The type of the event. Always `response.audio.transcript.delta`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when there is a partial transcript of audio.
        sig { params(delta: String, type: Symbol).returns(T.attached_class) }
        def self.new(delta:, type: :"response.audio.transcript.delta")
        end

        sig { override.returns({delta: String, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
