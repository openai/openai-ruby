# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseAudioTranscriptDoneEvent < OpenAI::BaseModel
        # The type of the event. Always `response.audio.transcript.done`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when the full audio transcript is completed.
        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(type: :"response.audio.transcript.done")
        end

        sig { override.returns({type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
