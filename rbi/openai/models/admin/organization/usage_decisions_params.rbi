# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class UsageDecisionsParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::UsageDecisionsParams,
              OpenAI::Internal::AnyHash
            )
          end

          # Start time (Unix seconds) of the query time range, inclusive.
          sig { returns(Integer) }
          attr_accessor :start_time

          # Return only usage for these API keys.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :api_key_ids

          # If `true`, return batch jobs only. If `false`, return non-batch jobs only. By
          # default, return both.
          sig { returns(T.nilable(T::Boolean)) }
          attr_accessor :batch

          # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
          # supported, default to `1d`.
          sig { returns(T.nilable(OpenAI::Admin::Organization::UsageDecisionsParams::BucketWidth::OrSymbol)) }
          attr_accessor :bucket_width

          # End time (Unix seconds) of the query time range, exclusive.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :end_time

          # Group the usage data by the specified fields. Support fields include
          # `project_id`, `user_id`, `api_key_id`, `model`, `batch`, `service_tier`,
          # `api_source` or any combination of them. When grouped by `api_source`, results
          # use `agents_api` for attributed Agents API activity and `unlabeled` for all
          # other activity. Without source grouping, `api_source` is null.
          sig { returns(T.nilable(T::Array[OpenAI::Admin::Organization::UsageDecisionsParams::GroupBy::OrSymbol])) }
          attr_accessor :group_by

          # Specifies the number of buckets to return.
          #
          # - `bucket_width=1d`: default: 7, max: 31
          # - `bucket_width=1h`: default: 24, max: 168
          # - `bucket_width=1m`: default: 60, max: 1440
          sig { returns(T.nilable(Integer)) }
          attr_accessor :limit

          # Return only usage for these models.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :models

          # A cursor for use in pagination. Corresponding to the `next_page` field from the
          # previous response.
          sig { returns(T.nilable(String)) }
          attr_accessor :page

          # Return only usage for these projects.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :project_ids

          # Return only usage for these users.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :user_ids

          sig do
            params(

              start_time: Integer,

              api_key_ids: T.nilable(T::Array[String]),

              batch: T.nilable(T::Boolean),

              bucket_width: T.nilable(OpenAI::Admin::Organization::UsageDecisionsParams::BucketWidth::OrSymbol),

              end_time: T.nilable(Integer),

              group_by: T.nilable(T::Array[OpenAI::Admin::Organization::UsageDecisionsParams::GroupBy::OrSymbol]),

              limit: T.nilable(Integer),

              models: T.nilable(T::Array[String]),

              page: T.nilable(String),

              project_ids: T.nilable(T::Array[String]),

              user_ids: T.nilable(T::Array[String]),

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,

            # Return only usage for these API keys.
            api_key_ids: nil,

            # If `true`, return batch jobs only. If `false`, return non-batch jobs only. By
            # default, return both.
            batch: nil,

            # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
            # supported, default to `1d`.
            bucket_width: nil,

            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,

            # Group the usage data by the specified fields. Support fields include
            # `project_id`, `user_id`, `api_key_id`, `model`, `batch`, `service_tier`,
            # `api_source` or any combination of them. When grouped by `api_source`, results
            # use `agents_api` for attributed Agents API activity and `unlabeled` for all
            # other activity. Without source grouping, `api_source` is null.
            group_by: nil,

            # Specifies the number of buckets to return.
            #
            # - `bucket_width=1d`: default: 7, max: 31
            # - `bucket_width=1h`: default: 24, max: 168
            # - `bucket_width=1m`: default: 60, max: 1440
            limit: nil,

            # Return only usage for these models.
            models: nil,

            # A cursor for use in pagination. Corresponding to the `next_page` field from the
            # previous response.
            page: nil,

            # Return only usage for these projects.
            project_ids: nil,

            # Return only usage for these users.
            user_ids: nil,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                start_time: Integer,
                api_key_ids: T.nilable(T::Array[String]),
                batch: T.nilable(T::Boolean),
                bucket_width: T.nilable(OpenAI::Admin::Organization::UsageDecisionsParams::BucketWidth::OrSymbol),
                end_time: T.nilable(Integer),
                group_by: T.nilable(T::Array[OpenAI::Admin::Organization::UsageDecisionsParams::GroupBy::OrSymbol]),
                limit: T.nilable(Integer),
                models: T.nilable(T::Array[String]),
                page: T.nilable(String),
                project_ids: T.nilable(T::Array[String]),
                user_ids: T.nilable(T::Array[String]),
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
          # supported, default to `1d`.
          module BucketWidth
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Admin::Organization::UsageDecisionsParams::BucketWidth)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            BUCKET_WIDTH_1M = T.let(:"1m", OpenAI::Admin::Organization::UsageDecisionsParams::BucketWidth::TaggedSymbol)
            BUCKET_WIDTH_1H = T.let(:"1h", OpenAI::Admin::Organization::UsageDecisionsParams::BucketWidth::TaggedSymbol)
            BUCKET_WIDTH_1D = T.let(:"1d", OpenAI::Admin::Organization::UsageDecisionsParams::BucketWidth::TaggedSymbol)

            sig {
              override.returns(T::Array[OpenAI::Admin::Organization::UsageDecisionsParams::BucketWidth::TaggedSymbol])
            }
            def self.values
            end
          end

          module GroupBy
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Admin::Organization::UsageDecisionsParams::GroupBy) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            PROJECT_ID = T.let(:project_id, OpenAI::Admin::Organization::UsageDecisionsParams::GroupBy::TaggedSymbol)
            USER_ID = T.let(:user_id, OpenAI::Admin::Organization::UsageDecisionsParams::GroupBy::TaggedSymbol)
            API_KEY_ID = T.let(:api_key_id, OpenAI::Admin::Organization::UsageDecisionsParams::GroupBy::TaggedSymbol)
            MODEL = T.let(:model, OpenAI::Admin::Organization::UsageDecisionsParams::GroupBy::TaggedSymbol)
            BATCH = T.let(:batch, OpenAI::Admin::Organization::UsageDecisionsParams::GroupBy::TaggedSymbol)
            SERVICE_TIER = T.let(
              :service_tier,
              OpenAI::Admin::Organization::UsageDecisionsParams::GroupBy::TaggedSymbol
            )
            API_SOURCE = T.let(:api_source, OpenAI::Admin::Organization::UsageDecisionsParams::GroupBy::TaggedSymbol)

            sig {
              override.returns(T::Array[OpenAI::Admin::Organization::UsageDecisionsParams::GroupBy::TaggedSymbol])
            }
            def self.values
            end
          end

        end

      end

    end

  end
end
