# typed: strong

module OpenAI
  module Models
    module Evals
      class RunCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(OpenAI::Evals::RunCreateParams, OpenAI::Internal::AnyHash)
          end

        # Details about the run's data source.
        sig do
          returns(
            T.any(
              OpenAI::Evals::CreateEvalJSONLRunDataSource,
              OpenAI::Evals::CreateEvalCompletionsRunDataSource,
              OpenAI::Evals::CreateEvalResponsesRunDataSource
            )
          )
        end
        attr_accessor :data_source

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # The name of the run.
        sig { returns(T.nilable(String)) }
        attr_reader :name

        sig { params(name: String).void }
        attr_writer :name

        sig do
          params(
            data_source:
              T.any(
                OpenAI::Evals::CreateEvalJSONLRunDataSource::OrHash,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::OrHash,
                OpenAI::Evals::CreateEvalResponsesRunDataSource::OrHash
              ),
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Details about the run's data source.
          data_source:,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # The name of the run.
          name: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              data_source:
                T.any(
                  OpenAI::Evals::CreateEvalJSONLRunDataSource,
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource,
                  OpenAI::Evals::CreateEvalResponsesRunDataSource
                ),
              metadata: T.nilable(T::Hash[Symbol, String]),
              name: String,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # Details about the run's data source.
        module DataSource
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalJSONLRunDataSource,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource,
                OpenAI::Evals::CreateEvalResponsesRunDataSource
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Evals::RunCreateParams::DataSource::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
