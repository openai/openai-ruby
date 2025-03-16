# typed: strong

module OpenAI
  module Models
    module Chat
      class CompletionListParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # Identifier for the last chat completion from the previous pagination request.
        sig { returns(T.nilable(String)) }
        def after
        end

        sig { params(_: String).returns(String) }
        def after=(_)
        end

        # Number of Chat Completions to retrieve.
        sig { returns(T.nilable(Integer)) }
        def limit
        end

        sig { params(_: Integer).returns(Integer) }
        def limit=(_)
        end

        # A list of metadata keys to filter the Chat Completions by. Example:
        #
        #   `metadata[key1]=value1&metadata[key2]=value2`
        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        # The model used to generate the Chat Completions.
        sig { returns(T.nilable(String)) }
        def model
        end

        sig { params(_: String).returns(String) }
        def model=(_)
        end

        # Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
        #   `desc` for descending order. Defaults to `asc`.
        sig { returns(T.nilable(Symbol)) }
        def order
        end

        sig { params(_: Symbol).returns(Symbol) }
        def order=(_)
        end

        sig do
          params(
            after: String,
            limit: Integer,
            metadata: T.nilable(OpenAI::Models::Metadata),
            model: String,
            order: Symbol,
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(after: nil, limit: nil, metadata: nil, model: nil, order: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                after: String,
                limit: Integer,
                metadata: T.nilable(OpenAI::Models::Metadata),
                model: String,
                order: Symbol,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
        #   `desc` for descending order. Defaults to `asc`.
        class Order < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          ASC = :asc
          DESC = :desc
        end
      end
    end
  end
end
