# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        class PermissionRetrieveParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # Identifier for the last permission ID from the previous pagination request.
          sig { returns(T.nilable(String)) }
          attr_reader :after

          sig { params(after: String).void }
          attr_writer :after

          # Number of permissions to retrieve.
          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          # The order in which to retrieve permissions.
          sig { returns(T.nilable(OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order::OrSymbol)) }
          attr_reader :order

          sig { params(order: OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order::OrSymbol).void }
          attr_writer :order

          # The ID of the project to get permissions for.
          sig { returns(T.nilable(String)) }
          attr_reader :project_id

          sig { params(project_id: String).void }
          attr_writer :project_id

          sig do
            params(
              after: String,
              limit: Integer,
              order: OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order::OrSymbol,
              project_id: String,
              request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
            )
              .returns(T.attached_class)
          end
          def self.new(after: nil, limit: nil, order: nil, project_id: nil, request_options: {}); end

          sig do
            override
              .returns(
                {
                  after: String,
                  limit: Integer,
                  order: OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order::OrSymbol,
                  project_id: String,
                  request_options: OpenAI::RequestOptions
                }
              )
          end
          def to_hash; end

          # The order in which to retrieve permissions.
          module Order
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ASCENDING =
              T.let(:ascending, OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order::TaggedSymbol)
            DESCENDING =
              T.let(:descending, OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order::TaggedSymbol)

            sig do
              override
                .returns(T::Array[OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveParams::Order::TaggedSymbol])
            end
            def self.values; end
          end
        end
      end
    end
  end
end
