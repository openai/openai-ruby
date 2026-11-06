# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class WorkloadIdentityProviderListParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::WorkloadIdentityProviderListParams,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(T.nilable(String)) }
          attr_reader :after

          sig { params(after: String).void }
          attr_writer :after

          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          sig { returns(T.nilable(OpenAI::Admin::Organization::WorkloadIdentityProviderListParams::Order::OrSymbol)) }
          attr_reader :order

          sig { params(order: OpenAI::Admin::Organization::WorkloadIdentityProviderListParams::Order::OrSymbol).void }
          attr_writer :order

          sig do
            params(

              after: String,

              limit: Integer,

              order: OpenAI::Admin::Organization::WorkloadIdentityProviderListParams::Order::OrSymbol,

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            after: nil,

            limit: nil,

            order: nil,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                after: String,
                limit: Integer,
                order: OpenAI::Admin::Organization::WorkloadIdentityProviderListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          module Order
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              OpenAI::Admin::Organization::WorkloadIdentityProviderListParams::Order::TaggedSymbol
            }

            sig {
              override.returns(
                T::Array[OpenAI::Admin::Organization::WorkloadIdentityProviderListParams::Order::Variants]
              )
            }
            def self.variants
            end

            TaggedSymbol = T.type_alias do
              T.all(Symbol, OpenAI::Admin::Organization::WorkloadIdentityProviderListParams::Order)
            end

            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ASC = T.let(:asc, OpenAI::Admin::Organization::WorkloadIdentityProviderListParams::Order::TaggedSymbol)
            DESC = T.let(:desc, OpenAI::Admin::Organization::WorkloadIdentityProviderListParams::Order::TaggedSymbol)

          end

        end

      end

    end

  end
end
