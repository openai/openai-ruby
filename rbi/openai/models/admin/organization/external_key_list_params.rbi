# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class ExternalKeyListParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::ExternalKeyListParams,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(T.nilable(String)) }
          attr_accessor :after

          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          sig { returns(T.nilable(OpenAI::Admin::Organization::ExternalKeyListParams::Order::OrSymbol)) }
          attr_reader :order

          sig { params(order: OpenAI::Admin::Organization::ExternalKeyListParams::Order::OrSymbol).void }
          attr_writer :order

          # Filter by key purpose. When omitted, returns keys of all purposes.
          sig { returns(T.nilable(OpenAI::Admin::Organization::ExternalKeyListParams::Purpose::OrSymbol)) }
          attr_reader :purpose

          sig { params(purpose: OpenAI::Admin::Organization::ExternalKeyListParams::Purpose::OrSymbol).void }
          attr_writer :purpose

          sig do
            params(

              after: T.nilable(String),

              limit: Integer,

              order: OpenAI::Admin::Organization::ExternalKeyListParams::Order::OrSymbol,

              purpose: OpenAI::Admin::Organization::ExternalKeyListParams::Purpose::OrSymbol,

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            after: nil,

            limit: nil,

            order: nil,

            # Filter by key purpose. When omitted, returns keys of all purposes.
            purpose: nil,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                after: T.nilable(String),
                limit: Integer,
                order: OpenAI::Admin::Organization::ExternalKeyListParams::Order::OrSymbol,
                purpose: OpenAI::Admin::Organization::ExternalKeyListParams::Purpose::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          module Order
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Admin::Organization::ExternalKeyListParams::Order) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ASC = T.let(:asc, OpenAI::Admin::Organization::ExternalKeyListParams::Order::TaggedSymbol)
            DESC = T.let(:desc, OpenAI::Admin::Organization::ExternalKeyListParams::Order::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Admin::Organization::ExternalKeyListParams::Order::TaggedSymbol]) }
            def self.values
            end
          end

          # Filter by key purpose. When omitted, returns keys of all purposes.
          module Purpose
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Admin::Organization::ExternalKeyListParams::Purpose) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            EKM = T.let(:ekm, OpenAI::Admin::Organization::ExternalKeyListParams::Purpose::TaggedSymbol)
            PSP_DECRYPTION = T.let(
              :psp_decryption,
              OpenAI::Admin::Organization::ExternalKeyListParams::Purpose::TaggedSymbol
            )

            sig {
              override.returns(T::Array[OpenAI::Admin::Organization::ExternalKeyListParams::Purpose::TaggedSymbol])
            }
            def self.values
            end
          end

        end

      end

    end

  end
end
