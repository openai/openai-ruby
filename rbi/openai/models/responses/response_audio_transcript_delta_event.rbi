# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseAudioTranscriptDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseAudioTranscriptDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The partial transcript of the audio response.
        sig { returns(String) }
        attr_accessor :delta

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.audio.transcript.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when there is a partial transcript of audio.
        sig do
          params(delta: String, sequence_number: Integer, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # The partial transcript of the audio response.
          delta:,
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always `response.audio.transcript.delta`.
          type: :"response.audio.transcript.delta"
        )
        end

        sig do
          override.returns(
            { delta: String, sequence_number: Integer, type: Symbol }
          )
        end
        def to_hash
        end
      end
    end
  end
end
