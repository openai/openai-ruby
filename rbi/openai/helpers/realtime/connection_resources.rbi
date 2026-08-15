# typed: strong

module OpenAI
  module Models
    module Realtime
      module ConnectionResources
        class Base
          # @api private
          sig do
            params(connection: OpenAI::Realtime::BaseConnection).returns(
              T.attached_class
            )
          end
          def self.new(connection)
          end
        end

        class Session < Base
          # Session fields intentionally remain open-ended here. The generated client
          # event union validates them at runtime and evolves with the protocol schema.
          sig { params(params: T.untyped).void }
          def update(**params)
          end
        end

        class TranscriptionSession < Base
          sig { params(params: T.untyped).void }
          def update(**params)
          end
        end

        class TranslationSession < Session
          sig { params(params: T.untyped).void }
          def update(**params)
          end

          sig { params(event_id: T.nilable(String)).void }
          def close(event_id: nil)
          end
        end

        class Response < Base
          # Response fields intentionally defer to the generated client event union.
          sig { params(params: T.untyped).void }
          def create(**params)
          end

          sig do
            params(
              response_id: T.nilable(String),
              event_id: T.nilable(String)
            ).void
          end
          def cancel(response_id: nil, event_id: nil)
          end
        end

        class InputAudioBuffer < Base
          sig { params(audio: String, event_id: T.nilable(String)).void }
          def append(audio:, event_id: nil)
          end

          sig { params(bytes: String, event_id: T.nilable(String)).void }
          def append_bytes(bytes, event_id: nil)
          end

          sig { params(event_id: T.nilable(String)).void }
          def commit(event_id: nil)
          end

          sig { params(event_id: T.nilable(String)).void }
          def clear(event_id: nil)
          end
        end

        class TranslationInputAudioBuffer < Base
          sig { params(audio: String, event_id: T.nilable(String)).void }
          def append(audio:, event_id: nil)
          end

          sig { params(bytes: String, event_id: T.nilable(String)).void }
          def append_bytes(bytes, event_id: nil)
          end
        end

        class Conversation < Base
          sig do
            returns(OpenAI::Realtime::ConnectionResources::ConversationItems)
          end
          attr_reader :items
        end

        class ConversationItems < Base
          # Item fields intentionally defer to the generated client event union.
          sig { params(params: T.untyped).void }
          def create(**params)
          end

          sig { params(item_id: String, event_id: T.nilable(String)).void }
          def delete(item_id:, event_id: nil)
          end

          sig { params(item_id: String, event_id: T.nilable(String)).void }
          def retrieve(item_id:, event_id: nil)
          end

          sig do
            params(
              item_id: String,
              content_index: Integer,
              audio_end_ms: Integer,
              event_id: T.nilable(String)
            ).void
          end
          def truncate(item_id:, content_index:, audio_end_ms:, event_id: nil)
          end

          sig do
            params(
              call_id: String,
              output: String,
              id: T.nilable(String),
              status: T.nilable(T.any(String, Symbol)),
              event_id: T.nilable(String)
            ).void
          end
          def create_function_call_output(
            call_id:,
            output:,
            id: nil,
            status: nil,
            event_id: nil
          )
          end

          sig do
            params(
              approval_request_id: String,
              approve: T::Boolean,
              reason: T.nilable(String),
              id: T.nilable(String),
              event_id: T.nilable(String)
            ).void
          end
          def respond_to_mcp_approval(
            approval_request_id:,
            approve:,
            reason: nil,
            id: nil,
            event_id: nil
          )
          end
        end

        class OutputAudioBuffer < Base
          sig { params(event_id: T.nilable(String)).void }
          def clear(event_id: nil)
          end
        end
      end
    end
  end
end
