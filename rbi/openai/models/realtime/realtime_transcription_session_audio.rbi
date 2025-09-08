# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeTranscriptionSessionAudio < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranscriptionSessionAudio,
              OpenAI::Internal::AnyHash
            )
          end

        sig do
          returns(
            T.nilable(OpenAI::Realtime::RealtimeTranscriptionSessionAudioInput)
          )
        end
        attr_reader :input

        sig do
          params(
            input:
              OpenAI::Realtime::RealtimeTranscriptionSessionAudioInput::OrHash
          ).void
        end
        attr_writer :input

        # Configuration for input and output audio.
        sig do
          params(
            input:
              OpenAI::Realtime::RealtimeTranscriptionSessionAudioInput::OrHash
          ).returns(T.attached_class)
        end
        def self.new(input: nil)
        end

        sig do
          override.returns(
            { input: OpenAI::Realtime::RealtimeTranscriptionSessionAudioInput }
          )
        end
        def to_hash
        end
      end
    end
  end
end
