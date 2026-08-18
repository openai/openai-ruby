# typed: strong

module OpenAI
  module Models
    module Realtime
      module ConnectionResources
        class Base
          # @api private
          sig { params(connection: OpenAI::Realtime::Connection).returns(T.attached_class) }
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

          sig { params(response_id: T.nilable(String), event_id: T.nilable(String)).void }
          def cancel(response_id: nil, event_id: nil)
          end
        end

        class Conversation < Base
          # @api private
          sig { params(connection: OpenAI::Realtime::Connection).returns(T.attached_class) }
          def self.new(connection)
          end

          sig { returns(OpenAI::Realtime::ConnectionResources::ConversationItems) }
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
