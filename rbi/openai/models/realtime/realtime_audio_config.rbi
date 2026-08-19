# typed: strong

module OpenAI
  module Models

    module Realtime

      class RealtimeAudioConfig < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Realtime::RealtimeAudioConfig,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(T.nilable(OpenAI::Realtime::RealtimeAudioConfigInput)) }
        attr_reader :input

        sig { params(input: OpenAI::Realtime::RealtimeAudioConfigInput::OrHash).void }
        attr_writer :input

        sig { returns(T.nilable(OpenAI::Realtime::RealtimeAudioConfigOutput)) }
        attr_reader :output

        sig { params(output: OpenAI::Realtime::RealtimeAudioConfigOutput::OrHash).void }
        attr_writer :output

        # Configuration for input and output audio.
        sig do
          params(

            input: OpenAI::Realtime::RealtimeAudioConfigInput::OrHash,

            output: OpenAI::Realtime::RealtimeAudioConfigOutput::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          input: nil,

          output: nil
        )
        end

        sig do
          override.returns(
            {input: OpenAI::Realtime::RealtimeAudioConfigInput, output: OpenAI::Realtime::RealtimeAudioConfigOutput}
          )
        end
        def to_hash
        end

      end

    end

  end
end
