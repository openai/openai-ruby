# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFileSearchToolCall < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseFileSearchToolCall,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the file search tool call.
        sig { returns(String) }
        attr_accessor :id

        # The queries used to search for files.
        sig { returns(T::Array[String]) }
        attr_accessor :queries

        # The status of the file search tool call. One of `in_progress`, `searching`,
        # `incomplete` or `failed`,
        sig do
          returns(
            OpenAI::Responses::ResponseFileSearchToolCall::Status::OrSymbol
          )
        end
        attr_accessor :status

        # The type of the file search tool call. Always `file_search_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The results of the file search tool call.
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Responses::ResponseFileSearchToolCall::Result]
            )
          )
        end
        attr_accessor :results

        # The results of a file search tool call. See the
        # [file search guide](https://platform.openai.com/docs/guides/tools-file-search)
        # for more information.
        sig do
          params(
            id: String,
            queries: T::Array[String],
            status:
              OpenAI::Responses::ResponseFileSearchToolCall::Status::OrSymbol,
            results:
              T.nilable(
                T::Array[
                  OpenAI::Responses::ResponseFileSearchToolCall::Result::OrHash
                ]
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the file search tool call.
          id:,
          # The queries used to search for files.
          queries:,
          # The status of the file search tool call. One of `in_progress`, `searching`,
          # `incomplete` or `failed`,
          status:,
          # The results of the file search tool call.
          results: nil,
          # The type of the file search tool call. Always `file_search_call`.
          type: :file_search_call
        )
        end

        sig do
          override.returns(
            {
              id: String,
              queries: T::Array[String],
              status:
                OpenAI::Responses::ResponseFileSearchToolCall::Status::OrSymbol,
              type: Symbol,
              results:
                T.nilable(
                  T::Array[
                    OpenAI::Responses::ResponseFileSearchToolCall::Result
                  ]
                )
            }
          )
        end
        def to_hash
        end

        # The status of the file search tool call. One of `in_progress`, `searching`,
        # `incomplete` or `failed`,
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Responses::ResponseFileSearchToolCall::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Responses::ResponseFileSearchToolCall::Status::TaggedSymbol
            )
          SEARCHING =
            T.let(
              :searching,
              OpenAI::Responses::ResponseFileSearchToolCall::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Responses::ResponseFileSearchToolCall::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Responses::ResponseFileSearchToolCall::Status::TaggedSymbol
            )
          FAILED =
            T.let(
              :failed,
              OpenAI::Responses::ResponseFileSearchToolCall::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseFileSearchToolCall::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        class Result < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseFileSearchToolCall::Result,
                OpenAI::Internal::AnyHash
              )
            end

          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard. Keys are strings with a maximum
          # length of 64 characters. Values are strings with a maximum length of 512
          # characters, booleans, or numbers.
          sig do
            returns(
              T.nilable(
                T::Hash[
                  Symbol,
                  OpenAI::Responses::ResponseFileSearchToolCall::Result::Attribute::Variants
                ]
              )
            )
          end
          attr_accessor :attributes

          # The unique ID of the file.
          sig { returns(T.nilable(String)) }
          attr_reader :file_id

          sig { params(file_id: String).void }
          attr_writer :file_id

          # The name of the file.
          sig { returns(T.nilable(String)) }
          attr_reader :filename

          sig { params(filename: String).void }
          attr_writer :filename

          # The relevance score of the file - a value between 0 and 1.
          sig { returns(T.nilable(Float)) }
          attr_reader :score

          sig { params(score: Float).void }
          attr_writer :score

          # The text that was retrieved from the file.
          sig { returns(T.nilable(String)) }
          attr_reader :text

          sig { params(text: String).void }
          attr_writer :text

          sig do
            params(
              attributes:
                T.nilable(
                  T::Hash[
                    Symbol,
                    OpenAI::Responses::ResponseFileSearchToolCall::Result::Attribute::Variants
                  ]
                ),
              file_id: String,
              filename: String,
              score: Float,
              text: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Set of 16 key-value pairs that can be attached to an object. This can be useful
            # for storing additional information about the object in a structured format, and
            # querying for objects via API or the dashboard. Keys are strings with a maximum
            # length of 64 characters. Values are strings with a maximum length of 512
            # characters, booleans, or numbers.
            attributes: nil,
            # The unique ID of the file.
            file_id: nil,
            # The name of the file.
            filename: nil,
            # The relevance score of the file - a value between 0 and 1.
            score: nil,
            # The text that was retrieved from the file.
            text: nil
          )
          end

          sig do
            override.returns(
              {
                attributes:
                  T.nilable(
                    T::Hash[
                      Symbol,
                      OpenAI::Responses::ResponseFileSearchToolCall::Result::Attribute::Variants
                    ]
                  ),
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
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias { T.any(String, Float, T::Boolean) }

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::ResponseFileSearchToolCall::Result::Attribute::Variants
                ]
              )
            end
            def self.variants
            end
          end
        end
      end
    end
  end
end
