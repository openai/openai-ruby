# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFileSearchToolCall < OpenAI::BaseModel
        # The unique ID of the file search tool call.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # The queries used to search for files.
        sig { returns(T::Array[String]) }
        def queries
        end

        sig { params(_: T::Array[String]).returns(T::Array[String]) }
        def queries=(_)
        end

        # The status of the file search tool call. One of `in_progress`, `searching`,
        #   `incomplete` or `failed`,
        sig { returns(OpenAI::Models::Responses::ResponseFileSearchToolCall::Status::OrSymbol) }
        def status
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseFileSearchToolCall::Status::OrSymbol)
            .returns(OpenAI::Models::Responses::ResponseFileSearchToolCall::Status::OrSymbol)
        end
        def status=(_)
        end

        # The type of the file search tool call. Always `file_search_call`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # The results of the file search tool call.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Responses::ResponseFileSearchToolCall::Result])) }
        def results
        end

        sig do
          params(_: T.nilable(T::Array[OpenAI::Models::Responses::ResponseFileSearchToolCall::Result]))
            .returns(T.nilable(T::Array[OpenAI::Models::Responses::ResponseFileSearchToolCall::Result]))
        end
        def results=(_)
        end

        # The results of a file search tool call. See the
        #   [file search guide](https://platform.openai.com/docs/guides/tools-file-search)
        #   for more information.
        sig do
          params(
            id: String,
            queries: T::Array[String],
            status: OpenAI::Models::Responses::ResponseFileSearchToolCall::Status::OrSymbol,
            results: T.nilable(T::Array[OpenAI::Models::Responses::ResponseFileSearchToolCall::Result]),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, queries:, status:, results: nil, type: :file_search_call)
        end

        sig do
          override
            .returns(
              {
                id: String,
                queries: T::Array[String],
                status: OpenAI::Models::Responses::ResponseFileSearchToolCall::Status::OrSymbol,
                type: Symbol,
                results: T.nilable(T::Array[OpenAI::Models::Responses::ResponseFileSearchToolCall::Result])
              }
            )
        end
        def to_hash
        end

        # The status of the file search tool call. One of `in_progress`, `searching`,
        #   `incomplete` or `failed`,
        module Status
          extend OpenAI::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseFileSearchToolCall::Status) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::ResponseFileSearchToolCall::Status::TaggedSymbol) }

          IN_PROGRESS =
            T.let(:in_progress, OpenAI::Models::Responses::ResponseFileSearchToolCall::Status::TaggedSymbol)
          SEARCHING =
            T.let(:searching, OpenAI::Models::Responses::ResponseFileSearchToolCall::Status::TaggedSymbol)
          COMPLETED =
            T.let(:completed, OpenAI::Models::Responses::ResponseFileSearchToolCall::Status::TaggedSymbol)
          INCOMPLETE =
            T.let(:incomplete, OpenAI::Models::Responses::ResponseFileSearchToolCall::Status::TaggedSymbol)
          FAILED = T.let(:failed, OpenAI::Models::Responses::ResponseFileSearchToolCall::Status::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseFileSearchToolCall::Status::TaggedSymbol]) }
            def values
            end
          end
        end

        class Result < OpenAI::BaseModel
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard. Keys are strings with a maximum
          #   length of 64 characters. Values are strings with a maximum length of 512
          #   characters, booleans, or numbers.
          sig { returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)])) }
          def attributes
          end

          sig do
            params(_: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
              .returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
          end
          def attributes=(_)
          end

          # The unique ID of the file.
          sig { returns(T.nilable(String)) }
          def file_id
          end

          sig { params(_: String).returns(String) }
          def file_id=(_)
          end

          # The name of the file.
          sig { returns(T.nilable(String)) }
          def filename
          end

          sig { params(_: String).returns(String) }
          def filename=(_)
          end

          # The relevance score of the file - a value between 0 and 1.
          sig { returns(T.nilable(Float)) }
          def score
          end

          sig { params(_: Float).returns(Float) }
          def score=(_)
          end

          # The text that was retrieved from the file.
          sig { returns(T.nilable(String)) }
          def text
          end

          sig { params(_: String).returns(String) }
          def text=(_)
          end

          sig do
            params(
              attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
              file_id: String,
              filename: String,
              score: Float,
              text: String
            )
              .returns(T.attached_class)
          end
          def self.new(attributes: nil, file_id: nil, filename: nil, score: nil, text: nil)
          end

          sig do
            override
              .returns(
                {
                  attributes: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]),
                  file_id: String,
                  filename: String,
                  score: Float,
                  text: String
                }
              )
          end
          def to_hash
          end

          module Attribute
            extend OpenAI::Union

            Variants = type_template(:out) { {fixed: T.any(String, Float, T::Boolean)} }

            class << self
              sig { override.returns([String, Float, T::Boolean]) }
              def variants
              end
            end
          end
        end
      end
    end
  end
end
