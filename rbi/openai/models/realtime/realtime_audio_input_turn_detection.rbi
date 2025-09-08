# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeAudioInputTurnDetection < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeAudioInputTurnDetection,
              OpenAI::Internal::AnyHash
            )
          end

        # Whether or not to automatically generate a response when a VAD stop event
        # occurs.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :create_response

        sig { params(create_response: T::Boolean).void }
        attr_writer :create_response

        # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
        # will wait longer for the user to continue speaking, `high` will respond more
        # quickly. `auto` is the default and is equivalent to `medium`. `low`, `medium`,
        # and `high` have max timeouts of 8s, 4s, and 2s respectively.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::Eagerness::OrSymbol
            )
          )
        end
        attr_reader :eagerness

        sig do
          params(
            eagerness:
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::Eagerness::OrSymbol
          ).void
        end
        attr_writer :eagerness

        # Optional idle timeout after which turn detection will auto-timeout when no
        # additional audio is received.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :idle_timeout_ms

        # Whether or not to automatically interrupt any ongoing response with output to
        # the default conversation (i.e. `conversation` of `auto`) when a VAD start event
        # occurs.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :interrupt_response

        sig { params(interrupt_response: T::Boolean).void }
        attr_writer :interrupt_response

        # Used only for `server_vad` mode. Amount of audio to include before the VAD
        # detected speech (in milliseconds). Defaults to 300ms.
        sig { returns(T.nilable(Integer)) }
        attr_reader :prefix_padding_ms

        sig { params(prefix_padding_ms: Integer).void }
        attr_writer :prefix_padding_ms

        # Used only for `server_vad` mode. Duration of silence to detect speech stop (in
        # milliseconds). Defaults to 500ms. With shorter values the model will respond
        # more quickly, but may jump in on short pauses from the user.
        sig { returns(T.nilable(Integer)) }
        attr_reader :silence_duration_ms

        sig { params(silence_duration_ms: Integer).void }
        attr_writer :silence_duration_ms

        # Used only for `server_vad` mode. Activation threshold for VAD (0.0 to 1.0), this
        # defaults to 0.5. A higher threshold will require louder audio to activate the
        # model, and thus might perform better in noisy environments.
        sig { returns(T.nilable(Float)) }
        attr_reader :threshold

        sig { params(threshold: Float).void }
        attr_writer :threshold

        # Type of turn detection.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::Type::OrSymbol
            )
          )
        end
        attr_reader :type

        sig do
          params(
            type:
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::Type::OrSymbol
          ).void
        end
        attr_writer :type

        # Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
        # set to `null` to turn off, in which case the client must manually trigger model
        # response. Server VAD means that the model will detect the start and end of
        # speech based on audio volume and respond at the end of user speech. Semantic VAD
        # is more advanced and uses a turn detection model (in conjunction with VAD) to
        # semantically estimate whether the user has finished speaking, then dynamically
        # sets a timeout based on this probability. For example, if user audio trails off
        # with "uhhm", the model will score a low probability of turn end and wait longer
        # for the user to continue speaking. This can be useful for more natural
        # conversations, but may have a higher latency.
        sig do
          params(
            create_response: T::Boolean,
            eagerness:
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::Eagerness::OrSymbol,
            idle_timeout_ms: T.nilable(Integer),
            interrupt_response: T::Boolean,
            prefix_padding_ms: Integer,
            silence_duration_ms: Integer,
            threshold: Float,
            type:
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::Type::OrSymbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Whether or not to automatically generate a response when a VAD stop event
          # occurs.
          create_response: nil,
          # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
          # will wait longer for the user to continue speaking, `high` will respond more
          # quickly. `auto` is the default and is equivalent to `medium`. `low`, `medium`,
          # and `high` have max timeouts of 8s, 4s, and 2s respectively.
          eagerness: nil,
          # Optional idle timeout after which turn detection will auto-timeout when no
          # additional audio is received.
          idle_timeout_ms: nil,
          # Whether or not to automatically interrupt any ongoing response with output to
          # the default conversation (i.e. `conversation` of `auto`) when a VAD start event
          # occurs.
          interrupt_response: nil,
          # Used only for `server_vad` mode. Amount of audio to include before the VAD
          # detected speech (in milliseconds). Defaults to 300ms.
          prefix_padding_ms: nil,
          # Used only for `server_vad` mode. Duration of silence to detect speech stop (in
          # milliseconds). Defaults to 500ms. With shorter values the model will respond
          # more quickly, but may jump in on short pauses from the user.
          silence_duration_ms: nil,
          # Used only for `server_vad` mode. Activation threshold for VAD (0.0 to 1.0), this
          # defaults to 0.5. A higher threshold will require louder audio to activate the
          # model, and thus might perform better in noisy environments.
          threshold: nil,
          # Type of turn detection.
          type: nil
        )
        end

        sig do
          override.returns(
            {
              create_response: T::Boolean,
              eagerness:
                OpenAI::Realtime::RealtimeAudioInputTurnDetection::Eagerness::OrSymbol,
              idle_timeout_ms: T.nilable(Integer),
              interrupt_response: T::Boolean,
              prefix_padding_ms: Integer,
              silence_duration_ms: Integer,
              threshold: Float,
              type:
                OpenAI::Realtime::RealtimeAudioInputTurnDetection::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # Used only for `semantic_vad` mode. The eagerness of the model to respond. `low`
        # will wait longer for the user to continue speaking, `high` will respond more
        # quickly. `auto` is the default and is equivalent to `medium`. `low`, `medium`,
        # and `high` have max timeouts of 8s, 4s, and 2s respectively.
        module Eagerness
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeAudioInputTurnDetection::Eagerness
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LOW =
            T.let(
              :low,
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::Eagerness::TaggedSymbol
            )
          MEDIUM =
            T.let(
              :medium,
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::Eagerness::TaggedSymbol
            )
          HIGH =
            T.let(
              :high,
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::Eagerness::TaggedSymbol
            )
          AUTO =
            T.let(
              :auto,
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::Eagerness::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeAudioInputTurnDetection::Eagerness::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # Type of turn detection.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeAudioInputTurnDetection::Type
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          SERVER_VAD =
            T.let(
              :server_vad,
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::Type::TaggedSymbol
            )
          SEMANTIC_VAD =
            T.let(
              :semantic_vad,
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeAudioInputTurnDetection::Type::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
