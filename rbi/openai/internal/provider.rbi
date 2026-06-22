# typed: strong

module OpenAI
  module Internal
    module Provider
      class Handle
        sig { returns(String) }
        def inspect
        end
      end

      class Runtime
        sig { returns(String) }
        attr_accessor :name

        sig { returns(String) }
        attr_accessor :base_url

        sig do
          returns(
            T.nilable(
              T
                .proc
                .params(
                  request: OpenAI::Internal::Transport::BaseClient::RequestInput
                )
                .returns(OpenAI::Internal::Transport::BaseClient::RequestInput)
            )
          )
        end
        attr_accessor :prepare_request
      end

      class << self
        sig do
          params(definition: T.untyped).returns(
            OpenAI::Internal::Provider::Handle
          )
        end
        def create(definition)
        end

        sig do
          params(provider: OpenAI::Internal::Provider::Handle).returns(String)
        end
        def name(provider)
        end

        sig do
          params(provider: OpenAI::Internal::Provider::Handle).returns(
            OpenAI::Internal::Provider::Runtime
          )
        end
        def configure(provider)
        end
      end
    end
  end
end
