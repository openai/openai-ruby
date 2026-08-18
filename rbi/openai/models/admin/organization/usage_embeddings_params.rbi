# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class UsageEmbeddingsParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::UsageEmbeddingsParams,
                OpenAI::Internal::AnyHash
              )
            end

          # Start time (Unix seconds) of the query time range, inclusive.
          sig { returns(Integer) }
          attr_accessor :start_time

          # Return only usage for these API keys.
          sig { returns(T.nilable(T::Array[String])) }
          attr_reader :api_key_ids

          sig { params(api_key_ids: T::Array[String]).void }
          attr_writer :api_key_ids

          # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
          # supported, default to `1d`.
          sig do
            returns(
              T.nilable(
                OpenAI::Admin::Organization::UsageEmbeddingsParams::BucketWidth::OrSymbol
              )
            )
          end
          attr_reader :bucket_width

          sig do
            params(
              bucket_width:
                OpenAI::Admin::Organization::UsageEmbeddingsParams::BucketWidth::OrSymbol
            ).void
          end
          attr_writer :bucket_width

          # End time (Unix seconds) of the query time range, exclusive.
          sig { returns(T.nilable(Integer)) }
          attr_reader :end_time

          sig { params(end_time: Integer).void }
          attr_writer :end_time

          # Group the usage data by the specified fields. Support fields include
          # `project_id`, `user_id`, `api_key_id`, `model` or any combination of them.
          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Admin::Organization::UsageEmbeddingsParams::GroupBy::OrSymbol
                ]
              )
            )
          end
          attr_reader :group_by

          sig do
            params(
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageEmbeddingsParams::GroupBy::OrSymbol
                ]
            ).void
          end
          attr_writer :group_by

          # Specifies the number of buckets to return.
          #
          # - `bucket_width=1d`: default: 7, max: 31
          # - `bucket_width=1h`: default: 24, max: 168
          # - `bucket_width=1m`: default: 60, max: 1440
          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          # Return only usage for these models.
          sig { returns(T.nilable(T::Array[String])) }
          attr_reader :models

          sig { params(models: T::Array[String]).void }
          attr_writer :models

          # A cursor for use in pagination. Corresponding to the `next_page` field from the
          # previous response.
          sig { returns(T.nilable(String)) }
          attr_reader :page

          sig { params(page: String).void }
          attr_writer :page

          # Return only usage for these projects.
          sig { returns(T.nilable(T::Array[String])) }
          attr_reader :project_ids

          sig { params(project_ids: T::Array[String]).void }
          attr_writer :project_ids

          # Return only usage for these users.
          sig { returns(T.nilable(T::Array[String])) }
          attr_reader :user_ids

          sig { params(user_ids: T::Array[String]).void }
          attr_writer :user_ids

          sig do
            params(
              start_time: Integer,
              api_key_ids: T::Array[String],
              bucket_width:
                OpenAI::Admin::Organization::UsageEmbeddingsParams::BucketWidth::OrSymbol,
              end_time: Integer,
              group_by:
                T::Array[
                  OpenAI::Admin::Organization::UsageEmbeddingsParams::GroupBy::OrSymbol
                ],
              limit: Integer,
              models: T::Array[String],
              page: String,
              project_ids: T::Array[String],
              user_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # Start time (Unix seconds) of the query time range, inclusive.
            start_time:,
            # Return only usage for these API keys.
            api_key_ids: nil,
            # Width of each time bucket in response. Currently `1m`, `1h` and `1d` are
            # supported, default to `1d`.
            bucket_width: nil,
            # End time (Unix seconds) of the query time range, exclusive.
            end_time: nil,
            # Group the usage data by the specified fields. Support fields include
            # `project_id`, `user_id`, `api_key_id`, `model` or any combination of them.
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
                api_key_ids: T::Array[String],
                bucket_width:
                  OpenAI::Admin::Organization::UsageEmbeddingsParams::BucketWidth::OrSymbol,
                end_time: Integer,
                group_by:
                  T::Array[
                    OpenAI::Admin::Organization::UsageEmbeddingsParams::GroupBy::OrSymbol
                  ],
                limit: Integer,
                models: T::Array[String],
                page: String,
                project_ids: T::Array[String],
                user_ids: T::Array[String],
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

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::UsageEmbeddingsParams::BucketWidth
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            BUCKET_WIDTH_1M =
              T.let(
                :"1m",
                OpenAI::Admin::Organization::UsageEmbeddingsParams::BucketWidth::TaggedSymbol
              )
            BUCKET_WIDTH_1H =
              T.let(
                :"1h",
                OpenAI::Admin::Organization::UsageEmbeddingsParams::BucketWidth::TaggedSymbol
              )
            BUCKET_WIDTH_1D =
              T.let(
                :"1d",
                OpenAI::Admin::Organization::UsageEmbeddingsParams::BucketWidth::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::UsageEmbeddingsParams::BucketWidth::TaggedSymbol
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
                  OpenAI::Admin::Organization::UsageEmbeddingsParams::GroupBy
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            PROJECT_ID =
              T.let(
                :project_id,
                OpenAI::Admin::Organization::UsageEmbeddingsParams::GroupBy::TaggedSymbol
              )
            USER_ID =
              T.let(
                :user_id,
                OpenAI::Admin::Organization::UsageEmbeddingsParams::GroupBy::TaggedSymbol
              )
            API_KEY_ID =
              T.let(
                :api_key_id,
                OpenAI::Admin::Organization::UsageEmbeddingsParams::GroupBy::TaggedSymbol
              )
            MODEL =
              T.let(
                :model,
                OpenAI::Admin::Organization::UsageEmbeddingsParams::GroupBy::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::UsageEmbeddingsParams::GroupBy::TaggedSymbol
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
