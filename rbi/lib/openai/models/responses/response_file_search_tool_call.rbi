# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFileSearchToolCall < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { returns(T::Array[String]) }
        def queries
        end

        sig { params(_: T::Array[String]).returns(T::Array[String]) }
        def queries=(_)
        end

        sig { returns(Symbol) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { returns(T.nilable(T::Array[OpenAI::Models::Responses::ResponseFileSearchToolCall::Result])) }
        def results
        end

        sig do
          params(_: T.nilable(T::Array[OpenAI::Models::Responses::ResponseFileSearchToolCall::Result]))
            .returns(T.nilable(T::Array[OpenAI::Models::Responses::ResponseFileSearchToolCall::Result]))
        end
        def results=(_)
        end

        sig do
          params(
            id: String,
            queries: T::Array[String],
            status: Symbol,
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
                status: Symbol,
                type: Symbol,
                results: T.nilable(T::Array[OpenAI::Models::Responses::ResponseFileSearchToolCall::Result])
              }
            )
        end
        def to_hash
        end

        class Status < OpenAI::Enum
          abstract!

          IN_PROGRESS = :in_progress
          SEARCHING = :searching
          COMPLETED = :completed
          INCOMPLETE = :incomplete
          FAILED = :failed

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class Result < OpenAI::BaseModel
          sig { returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)])) }
          def attributes
          end

          sig do
            params(_: T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
              .returns(T.nilable(T::Hash[Symbol, T.any(String, Float, T::Boolean)]))
          end
          def attributes=(_)
          end

          sig { returns(T.nilable(String)) }
          def file_id
          end

          sig { params(_: String).returns(String) }
          def file_id=(_)
          end

          sig { returns(T.nilable(String)) }
          def filename
          end

          sig { params(_: String).returns(String) }
          def filename=(_)
          end

          sig { returns(T.nilable(Float)) }
          def score
          end

          sig { params(_: Float).returns(Float) }
          def score=(_)
          end

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

          class Attribute < OpenAI::Union
            abstract!

            class << self
              sig { override.returns([[NilClass, String], [NilClass, Float], [NilClass, T::Boolean]]) }
              private def variants
              end
            end
          end
        end
      end
    end
  end
end
