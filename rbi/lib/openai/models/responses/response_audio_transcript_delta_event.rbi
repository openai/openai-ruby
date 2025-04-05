# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseAudioTranscriptDeltaEvent < OpenAI::Internal::Type::BaseModel
        # The partial transcript of the audio response.
        sig { returns(String) }
        attr_accessor :delta

        # The type of the event. Always `response.audio.transcript.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when there is a partial transcript of audio.
        sig { params(delta: String, type: Symbol).returns(T.attached_class) }
        def self.new(delta:, type: :"response.audio.transcript.delta"); end

        sig { override.returns({delta: String, type: Symbol}) }
        def to_hash; end
      end
    end
  end
end
