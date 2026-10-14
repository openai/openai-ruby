# typed: strong

module OpenAI
  module Models

    module Realtime

      class RealtimeTranslationOutputAudioDeltaEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # Base64-encoded translated audio data.
        sig { returns(String) }
        attr_accessor :delta

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The event type, must be `session.output_audio.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Number of audio channels.
        sig { returns(T.nilable(Integer)) }
        attr_reader :channels

        sig { params(channels: Integer).void }
        attr_writer :channels

        # Timing metadata for stream alignment, derived from the translation frame when
        # available. Treat `elapsed_ms` as alignment metadata, not a unique event
        # identifier.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :elapsed_ms

        # Audio encoding for `delta`.
        sig { returns(T.nilable(OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent::Format::OrSymbol)) }
        attr_reader :format_

        sig { params(format_: OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent::Format::OrSymbol).void }
        attr_writer :format_

        # Sample rate of the audio delta.
        sig { returns(T.nilable(Integer)) }
        attr_reader :sample_rate

        sig { params(sample_rate: Integer).void }
        attr_writer :sample_rate

        # Returned when translated output audio is available. The `delta` contains a PCM16
        # audio chunk whose length can vary. Clients should decode and queue the complete
        # delta instead of assuming a fixed byte or sample count.
        sig do
          params(

            delta: String,

            event_id: String,

            channels: Integer,

            elapsed_ms: T.nilable(Integer),

            format_: OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent::Format::OrSymbol,

            sample_rate: Integer,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Base64-encoded translated audio data.
          delta:,

          # The unique ID of the server event.
          event_id:,

          # Number of audio channels.
          channels: nil,

          # Timing metadata for stream alignment, derived from the translation frame when
          # available. Treat `elapsed_ms` as alignment metadata, not a unique event
          # identifier.
          elapsed_ms: nil,

          # Audio encoding for `delta`.
          format_: nil,

          # Sample rate of the audio delta.
          sample_rate: nil,

          # The event type, must be `session.output_audio.delta`.

          type: :"session.output_audio.delta"
        )
        end

        sig do
          override.returns(
            {
              delta: String,
              event_id: String,
              type: Symbol,
              channels: Integer,
              elapsed_ms: T.nilable(Integer),
              format_: OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent::Format::OrSymbol,
              sample_rate: Integer
            }
          )
        end
        def to_hash
        end

        # Audio encoding for `delta`.
        module Format
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias {
            T.all(Symbol, OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent::Format)
          }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          PCM16 = T.let(:pcm16, OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent::Format::TaggedSymbol)

          sig {
            override.returns(T::Array[OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent::Format::TaggedSymbol])
          }
          def self.values
          end
        end

      end

    end

  end
end
