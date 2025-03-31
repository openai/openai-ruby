# typed: strong

module OpenAI
  module Models
    module Chat
      class CompletionListParams < OpenAI::BaseModel
        extend OpenAI::Type::RequestParameters::Converter
        include OpenAI::RequestParameters

        # Identifier for the last chat completion from the previous pagination request.
        sig { returns(T.nilable(String)) }
        attr_reader :after

        sig { params(after: String).void }
        attr_writer :after

        # Number of Chat Completions to retrieve.
        sig { returns(T.nilable(Integer)) }
        attr_reader :limit

        sig { params(limit: Integer).void }
        attr_writer :limit

        # A list of metadata keys to filter the Chat Completions by. Example:
        #
        #   `metadata[key1]=value1&metadata[key2]=value2`
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # The model used to generate the Chat Completions.
        sig { returns(T.nilable(String)) }
        attr_reader :model

        sig { params(model: String).void }
        attr_writer :model

        # Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
        #   `desc` for descending order. Defaults to `asc`.
        sig { returns(T.nilable(OpenAI::Models::Chat::CompletionListParams::Order::OrSymbol)) }
        attr_reader :order

        sig { params(order: OpenAI::Models::Chat::CompletionListParams::Order::OrSymbol).void }
        attr_writer :order

        sig do
          params(
            after: String,
            limit: Integer,
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: String,
            order: OpenAI::Models::Chat::CompletionListParams::Order::OrSymbol,
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
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
                metadata: T.nilable(T::Hash[Symbol, String]),
                model: String,
                order: OpenAI::Models::Chat::CompletionListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
        #   `desc` for descending order. Defaults to `asc`.
        module Order
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::CompletionListParams::Order) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Chat::CompletionListParams::Order::TaggedSymbol) }

          ASC = T.let(:asc, OpenAI::Models::Chat::CompletionListParams::Order::TaggedSymbol)
          DESC = T.let(:desc, OpenAI::Models::Chat::CompletionListParams::Order::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Chat::CompletionListParams::Order::TaggedSymbol]) }
          def self.values
          end
        end
      end
    end
  end
end
