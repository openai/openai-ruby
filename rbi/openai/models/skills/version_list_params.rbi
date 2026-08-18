# typed: strong

module OpenAI
  module Models

    module Skills

      class VersionListParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Skills::VersionListParams,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :skill_id

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
        sig { returns(T.nilable(OpenAI::Skills::VersionListParams::Order::OrSymbol)) }
        attr_reader :order

        sig { params(order: OpenAI::Skills::VersionListParams::Order::OrSymbol).void }
        attr_writer :order

        sig do
          params(

            skill_id: String,

            after: String,

            limit: Integer,

            order: OpenAI::Skills::VersionListParams::Order::OrSymbol,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          skill_id:,

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
              skill_id: String,
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

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Skills::VersionListParams::Order) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ASC = T.let(:asc, OpenAI::Skills::VersionListParams::Order::TaggedSymbol)
          DESC = T.let(:desc, OpenAI::Skills::VersionListParams::Order::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Skills::VersionListParams::Order::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
