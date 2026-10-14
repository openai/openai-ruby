# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class UsageCostsParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::UsageCostsParams,
                OpenAI::Internal::AnyHash
              )
            end

          # Start time (Unix seconds) of the query time range, inclusive.
          sig { returns(Integer) }
          attr_accessor :start_time

          # Return only costs for these API keys.
          sig { returns(T.nilable(T::Array[String])) }
          attr_reader :api_key_ids

          sig { params(api_key_ids: T::Array[String]).void }
          attr_writer :api_key_ids

          # Width of each time bucket in response. Currently only `1d` is supported, default
          # to `1d`.
          sig do
            returns(
              T.nilable(
                OpenAI::Admin::Organization::UsageCostsParams::BucketWidth::OrSymbol
              )
            )
          end
          attr_reader :bucket_width

          sig do
            params(
              bucket_width:
                OpenAI::Admin::Organization::UsageCostsParams::BucketWidth::OrSymbol
            ).void
          end
          attr_writer :bucket_width

          # End time (Unix seconds) of the query time range, exclusive.
          sig { returns(T.nilable(Integer)) }
          attr_reader :end_time

          sig { params(end_time: Integer).void }
          attr_writer :end_time

          # Group the costs by the specified fields. Support fields include `project_id`,
          # `line_item`, `api_key_id` and any combination of them.
          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Admin::Organization::UsageCostsParams::GroupBy::OrSymbol
                ]
              )
            )
          end
          attr_reader :group_by

          sig do
            params(
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageCostsParams::GroupBy::OrSymbol
                ]
            ).void
          end
          attr_writer :group_by

          # A limit on the number of buckets to be returned. Limit can range between 1 and
          # 180, and the default is 7.
          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          # A cursor for use in pagination. Corresponding to the `next_page` field from the
          # previous response.
          sig { returns(T.nilable(String)) }
          attr_reader :page

          sig { params(page: String).void }
          attr_writer :page

          # Return only costs for these projects.
          sig { returns(T.nilable(T::Array[String])) }
          attr_reader :project_ids

          sig { params(project_ids: T::Array[String]).void }
          attr_writer :project_ids

          sig do
            params(
              start_time: Integer,
              api_key_ids: T::Array[String],
              bucket_width:
                OpenAI::Admin::Organization::UsageCostsParams::BucketWidth::OrSymbol,
              end_time: Integer,
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageCostsParams::GroupBy::OrSymbol
                ],
              limit: Integer,
              page: String,
              project_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,
            # Return only costs for these API keys.
            api_key_ids: nil,
            # Width of each time bucket in response. Currently only `1d` is supported, default
            # to `1d`.
            bucket_width: nil,
            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,
            # Group the costs by the specified fields. Support fields include `project_id`,
            # `line_item`, `api_key_id` and any combination of them.
            group_by: nil,
            # A limit on the number of buckets to be returned. Limit can range between 1 and
            # 180, and the default is 7.
            limit: nil,
            # A cursor for use in pagination. Corresponding to the `next_page` field from the
            # previous response.
            page: nil,
            # Return only costs for these projects.
            project_ids: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                start_time: Integer,
                api_key_ids: T::Array[String],
                bucket_width:
                  OpenAI::Admin::Organization::UsageCostsParams::BucketWidth::OrSymbol,
                end_time: Integer,
                group_by:
                  T::Array[
                    OpenAI::Admin::Organization::UsageCostsParams::GroupBy::OrSymbol
                  ],
                limit: Integer,
                page: String,
                project_ids: T::Array[String],
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # Width of each time bucket in response. Currently only `1d` is supported, default
          # to `1d`.
          module BucketWidth
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::UsageCostsParams::BucketWidth
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            BUCKET_WIDTH_1D =
              T.let(
                :"1d",
                OpenAI::Admin::Organization::UsageCostsParams::BucketWidth::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::UsageCostsParams::BucketWidth::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          module GroupBy
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::UsageCostsParams::GroupBy
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            PROJECT_ID =
              T.let(
                :project_id,
                OpenAI::Admin::Organization::UsageCostsParams::GroupBy::TaggedSymbol
              )
            LINE_ITEM =
              T.let(
                :line_item,
                OpenAI::Admin::Organization::UsageCostsParams::GroupBy::TaggedSymbol
              )
            API_KEY_ID =
              T.let(
                :api_key_id,
                OpenAI::Admin::Organization::UsageCostsParams::GroupBy::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::UsageCostsParams::GroupBy::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
