# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class ExternalStorageListParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::ExternalStorageListParams,
              OpenAI::Internal::AnyHash
            )
          end

          # Return external storage configurations after this ID.
          sig { returns(T.nilable(String)) }
          attr_accessor :after

          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          sig { returns(T.nilable(OpenAI::Admin::Organization::ExternalStorageListParams::Order::OrSymbol)) }
          attr_reader :order

          sig { params(order: OpenAI::Admin::Organization::ExternalStorageListParams::Order::OrSymbol).void }
          attr_writer :order

          sig { returns(T.nilable(String)) }
          attr_accessor :project_id

          sig do
            params(

              after: T.nilable(String),

              limit: Integer,

              order: OpenAI::Admin::Organization::ExternalStorageListParams::Order::OrSymbol,

              project_id: T.nilable(String),

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Return external storage configurations after this ID.
            after: nil,

            limit: nil,

            order: nil,

            project_id: nil,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                after: T.nilable(String),
                limit: Integer,
                order: OpenAI::Admin::Organization::ExternalStorageListParams::Order::OrSymbol,
                project_id: T.nilable(String),
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          module Order
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Admin::Organization::ExternalStorageListParams::Order)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ASC = T.let(:asc, OpenAI::Admin::Organization::ExternalStorageListParams::Order::TaggedSymbol)
            DESC = T.let(:desc, OpenAI::Admin::Organization::ExternalStorageListParams::Order::TaggedSymbol)

            sig {
              override.returns(T::Array[OpenAI::Admin::Organization::ExternalStorageListParams::Order::TaggedSymbol])
            }
            def self.values
            end
          end

        end

      end

    end

  end
end
