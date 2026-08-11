# typed: strong

module OpenAI
  module Resources
    class Beta
      class ChatKit
        sig { returns(ChatKit::WithRawResponse) }
        def with_raw_response
        end

        sig { returns(OpenAI::Resources::Beta::ChatKit::Sessions) }
        attr_reader :sessions

        sig { returns(OpenAI::Resources::Beta::ChatKit::Threads) }
        attr_reader :threads

        # @api private
        sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
        def self.new(client:)
        end

        class WithRawResponse
          sig { returns(OpenAI::Resources::Beta::ChatKit::Sessions::WithRawResponse) }
          attr_reader :sessions

          sig { returns(OpenAI::Resources::Beta::ChatKit::Threads::WithRawResponse) }
          attr_reader :threads

          # @api private
          sig { params(resource: ChatKit).returns(T.attached_class) }
          def self.new(resource:)
          end
        end
      end
    end
  end
end
