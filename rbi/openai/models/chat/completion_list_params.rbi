# typed: strong

module OpenAI
  module Models
    module Chat
      class CompletionListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
        # `metadata[key1]=value1&metadata[key2]=value2`
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # The model used to generate the Chat Completions.
        sig { returns(T.nilable(String)) }
        attr_reader :model

        sig { params(model: String).void }
        attr_writer :model

        # Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
        # `desc` for descending order. Defaults to `asc`.
        sig do
          returns(
            T.nilable(OpenAI::Chat::CompletionListParams::Order::OrSymbol)
          )
        end
        attr_reader :order

        sig do
          params(
            order: OpenAI::Chat::CompletionListParams::Order::OrSymbol
          ).void
        end
        attr_writer :order

        sig do
          params(
            after: String,
            limit: Integer,
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: String,
            order: OpenAI::Chat::CompletionListParams::Order::OrSymbol,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Identifier for the last chat completion from the previous pagination request.
          after: nil,
          # Number of Chat Completions to retrieve.
          limit: nil,
          # A list of metadata keys to filter the Chat Completions by. Example:
          #
          # `metadata[key1]=value1&metadata[key2]=value2`
          metadata: nil,
          # The model used to generate the Chat Completions.
          model: nil,
          # Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
          # `desc` for descending order. Defaults to `asc`.
          order: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              after: String,
              limit: Integer,
              metadata: T.nilable(T::Hash[Symbol, String]),
              model: String,
              order: OpenAI::Chat::CompletionListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
        # `desc` for descending order. Defaults to `asc`.
        module Order
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Chat::CompletionListParams::Order)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ASC =
            T.let(:asc, OpenAI::Chat::CompletionListParams::Order::TaggedSymbol)
          DESC =
            T.let(
              :desc,
              OpenAI::Chat::CompletionListParams::Order::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Chat::CompletionListParams::Order::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
