# typed: strong

module OpenAI
  module Models
    module Realtime
      # Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
      # set to `null` to turn off, in which case the client must manually trigger model
      # response.
      #
      # Server VAD means that the model will detect the start and end of speech based on
      # audio volume and respond at the end of user speech.
      #
      # Semantic VAD is more advanced and uses a turn detection model (in conjunction
      # with VAD) to semantically estimate whether the user has finished speaking, then
      # dynamically sets a timeout based on this probability. For example, if user audio
      # trails off with "uhhm", the model will score a low probability of turn end and
      # wait longer for the user to continue speaking. This can be useful for more
      # natural conversations, but may have a higher latency.
      module RealtimeTranscriptionSessionAudioInputTurnDetection
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::ServerVad,
              OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::SemanticVad
            )
          end

        class ServerVad < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::ServerVad,
                OpenAI::Internal::AnyHash
              )
            end

          # Type of turn detection, `server_vad` to turn on simple Server VAD.
          sig { returns(Symbol) }
          attr_accessor :type

          # Whether or not to automatically generate a response when a VAD stop event
          # occurs. If `interrupt_response` is set to `false` this may fail to create a
          # response if the model is already responding.
          #
          # If both `create_response` and `interrupt_response` are set to `false`, the model
          # will never respond automatically but VAD events will still be emitted.
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :create_response

          sig { params(create_response: T::Boolean).void }
          attr_writer :create_response

          # Optional timeout after which a model response will be triggered automatically.
          # This is useful for situations in which a long pause from the user is unexpected,
          # such as a phone call. The model will effectively prompt the user to continue the
          # conversation based on the current context.
          #
          # The timeout value will be applied after the last model response's audio has
          # finished playing, i.e. it's set to the `response.done` time plus audio playback
          # duration.
          #
          # An `input_audio_buffer.timeout_triggered` event (plus events associated with the
          # Response) will be emitted when the timeout is reached. Idle timeout is currently
          # only supported for `server_vad` mode.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :idle_timeout_ms

          # Whether or not to automatically interrupt (cancel) any ongoing response with
          # output to the default conversation (i.e. `conversation` of `auto`) when a VAD
          # start event occurs. If `true` then the response will be cancelled, otherwise it
          # will continue until complete.
          #
          # If both `create_response` and `interrupt_response` are set to `false`, the model
          # will never respond automatically but VAD events will still be emitted.
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

          # Server-side voice activity detection (VAD) which flips on when user speech is
          # detected and off after a period of silence.
          sig do
            params(
              create_response: T::Boolean,
              idle_timeout_ms: T.nilable(Integer),
              interrupt_response: T::Boolean,
              prefix_padding_ms: Integer,
              silence_duration_ms: Integer,
              threshold: Float,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Whether or not to automatically generate a response when a VAD stop event
            # occurs. If `interrupt_response` is set to `false` this may fail to create a
            # response if the model is already responding.
            #
            # If both `create_response` and `interrupt_response` are set to `false`, the model
            # will never respond automatically but VAD events will still be emitted.
            create_response: nil,
            # Optional timeout after which a model response will be triggered automatically.
            # This is useful for situations in which a long pause from the user is unexpected,
            # such as a phone call. The model will effectively prompt the user to continue the
            # conversation based on the current context.
            #
            # The timeout value will be applied after the last model response's audio has
            # finished playing, i.e. it's set to the `response.done` time plus audio playback
            # duration.
            #
            # An `input_audio_buffer.timeout_triggered` event (plus events associated with the
            # Response) will be emitted when the timeout is reached. Idle timeout is currently
            # only supported for `server_vad` mode.
            idle_timeout_ms: nil,
            # Whether or not to automatically interrupt (cancel) any ongoing response with
            # output to the default conversation (i.e. `conversation` of `auto`) when a VAD
            # start event occurs. If `true` then the response will be cancelled, otherwise it
            # will continue until complete.
            #
            # If both `create_response` and `interrupt_response` are set to `false`, the model
            # will never respond automatically but VAD events will still be emitted.
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
            # Type of turn detection, `server_vad` to turn on simple Server VAD.
            type: :server_vad
          )
          end

          sig do
            override.returns(
              {
                type: Symbol,
                create_response: T::Boolean,
                idle_timeout_ms: T.nilable(Integer),
                interrupt_response: T::Boolean,
                prefix_padding_ms: Integer,
                silence_duration_ms: Integer,
                threshold: Float
              }
            )
          end
          def to_hash
          end
        end

        class SemanticVad < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::SemanticVad,
                OpenAI::Internal::AnyHash
              )
            end

          # Type of turn detection, `semantic_vad` to turn on Semantic VAD.
          sig { returns(Symbol) }
          attr_accessor :type

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
                OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::SemanticVad::Eagerness::OrSymbol
              )
            )
          end
          attr_reader :eagerness

          sig do
            params(
              eagerness:
                OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::SemanticVad::Eagerness::OrSymbol
            ).void
          end
          attr_writer :eagerness

          # Whether or not to automatically interrupt any ongoing response with output to
          # the default conversation (i.e. `conversation` of `auto`) when a VAD start event
          # occurs.
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :interrupt_response

          sig { params(interrupt_response: T::Boolean).void }
          attr_writer :interrupt_response

          # Server-side semantic turn detection which uses a model to determine when the
          # user has finished speaking.
          sig do
            params(
              create_response: T::Boolean,
              eagerness:
                OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::SemanticVad::Eagerness::OrSymbol,
              interrupt_response: T::Boolean,
              type: Symbol
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
            # Whether or not to automatically interrupt any ongoing response with output to
            # the default conversation (i.e. `conversation` of `auto`) when a VAD start event
            # occurs.
            interrupt_response: nil,
            # Type of turn detection, `semantic_vad` to turn on Semantic VAD.
            type: :semantic_vad
          )
          end

          sig do
            override.returns(
              {
                type: Symbol,
                create_response: T::Boolean,
                eagerness:
                  OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::SemanticVad::Eagerness::OrSymbol,
                interrupt_response: T::Boolean
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
                  OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::SemanticVad::Eagerness
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            LOW =
              T.let(
                :low,
                OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::SemanticVad::Eagerness::TaggedSymbol
              )
            MEDIUM =
              T.let(
                :medium,
                OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::SemanticVad::Eagerness::TaggedSymbol
              )
            HIGH =
              T.let(
                :high,
                OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::SemanticVad::Eagerness::TaggedSymbol
              )
            AUTO =
              T.let(
                :auto,
                OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::SemanticVad::Eagerness::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::SemanticVad::Eagerness::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        sig do
          override.returns(
            T::Array[
              OpenAI::Realtime::RealtimeTranscriptionSessionAudioInputTurnDetection::Variants
            ]
          )
        end
        def self.variants
        end
      end
    end
  end
end
