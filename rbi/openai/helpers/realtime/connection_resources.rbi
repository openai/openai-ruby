# typed: strong

module OpenAI
  module Models
    module Realtime
      module ConnectionResources
        class Base
          # @api private
          sig do
            params(connection: OpenAI::Realtime::Connection).returns(
              T.attached_class
            )
          end
          def self.new(connection)
          end
        end

        class Session < Base
          sig { params(params: T.untyped).void }
          def update(**params)
          end
        end

        class Response < Base
          sig { params(params: T.untyped).void }
          def create(**params)
          end

          sig do
            params(
              response_id: T.nilable(String),
              event_id: T.nilable(String)
            )
              .void
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

        class Conversation < Base
          # @api private
          sig do
            params(connection: OpenAI::Realtime::Connection).returns(
              T.attached_class
            )
          end
          def self.new(connection)
          end

          sig do
            returns(OpenAI::Realtime::ConnectionResources::ConversationItems)
          end

          attr_reader :items
        end

        class ConversationItems < Base
          sig { params(params: T.untyped).void }
          def create(**params)
          end

          sig { params(item_id: String, event_id: T.nilable(String)).void }
          def delete(item_id:, event_id: nil)
          end

          sig { params(item_id: String, event_id: T.nilable(String)).void }
          def retrieve(item_id:, event_id: nil)
          end
        end
      end
    end
  end
end
