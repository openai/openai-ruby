# typed: strong

module OpenAI
  module Internal
    module Provider
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

        sig { returns(T::Array[String]) }
        attr_accessor :authentication_headers
      end

      class << self
        sig { params(definition: T.untyped).returns(OpenAI::Provider) }
        def create(definition)
        end

        sig { params(provider: OpenAI::Provider).returns(String) }
        def name(provider)
        end

        sig do
          params(provider: OpenAI::Provider).returns(
            OpenAI::Internal::Provider::Runtime
          )
        end
        def configure(provider)
        end
      end
    end
  end
end
