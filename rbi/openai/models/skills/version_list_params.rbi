# typed: strong

module OpenAI
  module Models
    module Skills
      class VersionListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(OpenAI::Skills::VersionListParams, OpenAI::Internal::AnyHash)
          end

        # The skill version ID to start after.
        sig { returns(T.nilable(String)) }
        attr_reader :after

        sig { params(after: String).void }
        attr_writer :after

        # Number of versions to retrieve.
        sig { returns(T.nilable(Integer)) }
        attr_reader :limit

        sig { params(limit: Integer).void }
        attr_writer :limit

        # Sort order of results by version number.
        sig do
          returns(T.nilable(OpenAI::Skills::VersionListParams::Order::OrSymbol))
        end
        attr_reader :order

        sig do
          params(order: OpenAI::Skills::VersionListParams::Order::OrSymbol).void
        end
        attr_writer :order

        sig do
          params(
            after: String,
            limit: Integer,
            order: OpenAI::Skills::VersionListParams::Order::OrSymbol,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # The skill version ID to start after.
          after: nil,
          # Number of versions to retrieve.
          limit: nil,
          # Sort order of results by version number.
          order: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              after: String,
              limit: Integer,
              order: OpenAI::Skills::VersionListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # Sort order of results by version number.
        module Order
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Skills::VersionListParams::Order)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ASC =
            T.let(:asc, OpenAI::Skills::VersionListParams::Order::TaggedSymbol)
          DESC =
            T.let(:desc, OpenAI::Skills::VersionListParams::Order::TaggedSymbol)

          sig do
            override.returns(
              T::Array[OpenAI::Skills::VersionListParams::Order::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
