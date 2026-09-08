# typed: strong

module OpenAI
  module Models
    module Realtime
      class AudioSession
        sig { returns(OpenAI::Realtime::AudioSession) }
        def start
        end

        sig { returns(OpenAI::Realtime::AudioSession) }
        def mute
        end

        sig { returns(OpenAI::Realtime::AudioSession) }
        def unmute
        end

        sig { returns(Symbol) }
        def state
        end

        sig { returns(NilClass) }
        def close
        end

        sig { returns(NilClass) }
        def wait
        end

        sig { returns(NilClass) }
        def respond
        end

        sig { returns(OpenAI::Realtime::AudioSession::InputTurn) }
        def start_turn
        end

        sig { returns(OpenAI::Realtime::AudioSession::Interruption) }
        def interrupt
        end

        sig { params(text: String).returns(NilClass) }
        def send_text(text)
        end

        sig { params(call_id: String, output: String).returns(NilClass) }
        def submit_tool_output(call_id:, output:)
        end

        Event = T.type_alias {
          T.any(
            OpenAI::Realtime::Connection::ServerEvent,
            OpenAI::Realtime::AudioSession::PlaybackStarted,
            OpenAI::Realtime::AudioSession::PlaybackFinished,
            OpenAI::Realtime::AudioSession::PlaybackInterrupted,
            OpenAI::Realtime::AudioSession::InputStateChanged,
            OpenAI::Realtime::AudioSession::Closed
          )
        }
        sig {
          params(block: T.nilable(T.proc.params(event: Event).void)).returns(
            T.any(T::Enumerator[Event], OpenAI::Realtime::AudioSession)
          )
        }
        def each(&block)
        end

        class InputTurn
          # @api private
          sig {
            params(session: OpenAI::Realtime::AudioSession).returns(
              T.nilable([Symbol, T.nilable(OpenAI::Errors::RealtimeAudioTurnError)])
            )
          }
          def completion_for(session)
          end

          # @api private
          sig { params(action: Symbol, error: T.nilable(OpenAI::Errors::RealtimeAudioTurnError)).returns(NilClass) }
          def record_completion(action, error: nil)
          end

          sig { returns(NilClass) }
          def commit
          end

          sig { returns(NilClass) }
          def discard
          end
        end

        class PlaybackStarted
          sig { params(response_id: String, item_id: String, content_index: Integer).returns(T.attached_class) }
          def self.new(response_id:, item_id:, content_index:)
          end

          sig { returns(String) }
          attr_reader :response_id
          sig { returns(String) }
          attr_reader :item_id
          sig { returns(Integer) }
          attr_reader :content_index
        end

        class PlaybackFinished
          sig {
            params(
              response_id: String,
              item_id: String,
              content_index: Integer,
              position: OpenAI::LocalAudio::PlaybackPosition
            )
              .returns(T.attached_class)
          }
          def self.new(response_id:, item_id:, content_index:, position:)
          end

          sig { returns(String) }
          attr_reader :response_id
          sig { returns(String) }
          attr_reader :item_id
          sig { returns(Integer) }
          attr_reader :content_index
          sig { returns(OpenAI::LocalAudio::PlaybackPosition) }
          attr_reader :position
        end

        class PlaybackInterrupted
          sig {
            params(
              response_id: String,
              item_id: String,
              content_index: Integer,
              position: OpenAI::LocalAudio::PlaybackPosition,
              reason: Symbol
            )
              .returns(T.attached_class)
          }
          def self.new(response_id:, item_id:, content_index:, position:, reason:)
          end

          sig { returns(String) }
          attr_reader :response_id
          sig { returns(String) }
          attr_reader :item_id
          sig { returns(Integer) }
          attr_reader :content_index
          sig { returns(OpenAI::LocalAudio::PlaybackPosition) }
          attr_reader :position
          sig { returns(Symbol) }
          attr_reader :reason
        end

        class ItemPosition
          sig {
            params(
              response_id: String,
              item_id: String,
              content_index: Integer,
              position: OpenAI::LocalAudio::PlaybackPosition
            )
              .returns(T.attached_class)
          }
          def self.new(response_id:, item_id:, content_index:, position:)
          end

          sig { returns(String) }
          attr_reader :response_id
          sig { returns(String) }
          attr_reader :item_id
          sig { returns(Integer) }
          attr_reader :content_index
          sig { returns(OpenAI::LocalAudio::PlaybackPosition) }
          attr_reader :position
        end

        class Interruption
          sig { params(items: T::Array[OpenAI::Realtime::AudioSession::ItemPosition]).returns(T.attached_class) }
          def self.new(items:)
          end

          sig { returns(T::Array[OpenAI::Realtime::AudioSession::ItemPosition]) }
          attr_reader :items
        end

        class InputStateChanged
          sig { params(capturing: T::Boolean, muted: T::Boolean, reason: Symbol).returns(T.attached_class) }
          def self.new(capturing:, muted:, reason:)
          end

          sig { returns(T::Boolean) }
          attr_reader :capturing
          sig { returns(T::Boolean) }
          attr_reader :muted
          sig { returns(Symbol) }
          attr_reader :reason
        end

        class Closed
          sig { params(reason: Symbol).returns(T.attached_class) }
          def self.new(reason:)
          end

          sig { returns(Symbol) }
          attr_reader :reason
        end
      end
    end
  end

  module Errors
    class RealtimeAudioSessionError < OpenAI::Errors::Error
    end

    class RealtimeAudioTurnError < OpenAI::Errors::RealtimeAudioSessionError
      sig { returns(OpenAI::Realtime::RealtimeErrorEvent) }
      attr_reader :event
      # @api private
      sig { params(event: OpenAI::Realtime::RealtimeErrorEvent).returns(T.attached_class) }
      def self.new(event:)
      end
    end

    class RealtimeAudioStateError < OpenAI::Errors::RealtimeAudioSessionError
    end

    class RealtimeAudioConsumerTooSlowError < OpenAI::Errors::RealtimeAudioSessionError
    end
  end

  module Resources
    class Realtime
      sig {
        type_parameters(:U)
          .params(
            model: String,
            voice: String,
            mode: Symbol,
            input_device: T.nilable(T.any(String, OpenAI::LocalAudio::Device)),
            output_device: T.nilable(T.any(String, OpenAI::LocalAudio::Device)),
            playback_policy: Symbol,
            turn_detection: OpenAI::Internal::AnyHash,
            session: OpenAI::Internal::AnyHash,
            audio_options: OpenAI::Internal::AnyHash,
            websocket_base_url: T.nilable(String),
            request_options: T.nilable(OpenAI::RequestOptions::OrHash),
            transport_options: OpenAI::Internal::AnyHash,
            block: T.proc.params(audio: OpenAI::Realtime::AudioSession).returns(T.type_parameter(:U))
          )
          .returns(T.type_parameter(:U))
      }
      def connect_audio(
        model:,
        voice:,
        mode: :server_vad,
        input_device: nil,
        output_device: nil,
        playback_policy: :duplex,
        turn_detection: {},
        session: {},
        audio_options: {},
        websocket_base_url: nil,
        request_options: nil,
        transport_options: {},
        &block
      )
      end
    end
  end
end
