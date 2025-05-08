# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionWebSearch < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The unique ID of the web search tool call.
        sig { returns(String) }
        attr_accessor :id

        # The status of the web search tool call.
        sig do
          returns(
            OpenAI::Responses::ResponseFunctionWebSearch::Status::OrSymbol
          )
        end
        attr_accessor :status

        # The type of the web search tool call. Always `web_search_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The results of a web search tool call. See the
        # [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for
        # more information.
        sig do
          params(
            id: String,
            status:
              OpenAI::Responses::ResponseFunctionWebSearch::Status::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the web search tool call.
          id:,
          # The status of the web search tool call.
          status:,
          # The type of the web search tool call. Always `web_search_call`.
          type: :web_search_call
        )
        end

        sig do
          override.returns(
            {
              id: String,
              status:
                OpenAI::Responses::ResponseFunctionWebSearch::Status::OrSymbol,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # The status of the web search tool call.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Responses::ResponseFunctionWebSearch::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol
            )
          SEARCHING =
            T.let(
              :searching,
              OpenAI::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol
            )
          FAILED =
            T.let(
              :failed,
              OpenAI::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseFunctionWebSearch::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
