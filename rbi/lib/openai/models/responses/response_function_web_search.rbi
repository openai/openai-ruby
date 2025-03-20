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
        sig { returns(OpenAI::Models::Responses::ResponseFunctionWebSearch::Status::OrSymbol) }
        def status
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseFunctionWebSearch::Status::OrSymbol)
            .returns(OpenAI::Models::Responses::ResponseFunctionWebSearch::Status::OrSymbol)
        end
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
        sig do
          params(
            id: String,
            status: OpenAI::Models::Responses::ResponseFunctionWebSearch::Status::OrSymbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, status:, type: :web_search_call)
        end

        sig do
          override
            .returns(
              {id: String, status: OpenAI::Models::Responses::ResponseFunctionWebSearch::Status::OrSymbol, type: Symbol}
            )
        end
        def to_hash
        end

        # The status of the web search tool call.
        module Status
          extend OpenAI::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseFunctionWebSearch::Status) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol) }

          IN_PROGRESS =
            T.let(:in_progress, OpenAI::Models::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol)
          SEARCHING = T.let(:searching, OpenAI::Models::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol)
          COMPLETED = T.let(:completed, OpenAI::Models::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol)
          FAILED = T.let(:failed, OpenAI::Models::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
