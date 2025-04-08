# typed: strong

module OpenAI
  module Models
    module Evals
      class RunCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # Details about the run's data source.
        sig do
          returns(
            T.any(
              OpenAI::Models::Evals::CreateEvalJSONLRunDataSource,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource
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
            data_source: T.any(
              OpenAI::Models::Evals::CreateEvalJSONLRunDataSource,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource
            ),
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: String,
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(data_source:, metadata: nil, name: nil, request_options: {}); end

        sig do
          override
            .returns(
              {
                data_source: T.any(
                  OpenAI::Models::Evals::CreateEvalJSONLRunDataSource,
                  OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource
                ),
                metadata: T.nilable(T::Hash[Symbol, String]),
                name: String,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash; end

        # Details about the run's data source.
        module DataSource
          extend OpenAI::Internal::Type::Union

          sig do
            override
              .returns(
                [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource]
              )
          end
          def self.variants; end
        end
      end
    end
  end
end
