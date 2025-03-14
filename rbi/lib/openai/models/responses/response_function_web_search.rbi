# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionWebSearch < OpenAI::BaseModel
        # The unique ID of the web search tool call.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # The status of the web search tool call.
        sig { returns(Symbol) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        # The type of the web search tool call. Always `web_search_call`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # The results of a web search tool call. See the
        #   [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for
        #   more information.
        sig { params(id: String, status: Symbol, type: Symbol).returns(T.attached_class) }
        def self.new(id:, status:, type: :web_search_call)
        end

        sig { override.returns({id: String, status: Symbol, type: Symbol}) }
        def to_hash
        end

        # The status of the web search tool call.
        class Status < OpenAI::Enum
          abstract!

          IN_PROGRESS = :in_progress
          SEARCHING = :searching
          COMPLETED = :completed
          FAILED = :failed

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
