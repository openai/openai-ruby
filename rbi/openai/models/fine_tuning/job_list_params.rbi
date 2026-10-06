# typed: strong

module OpenAI
  module Models

    module FineTuning

      class JobListParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::FineTuning::JobListParams,
            OpenAI::Internal::AnyHash
          )
        end

        # Identifier for the last job from the previous pagination request.
        sig { returns(T.nilable(String)) }
        attr_reader :after

        sig { params(after: String).void }
        attr_writer :after

        # Number of fine-tuning jobs to retrieve.
        sig { returns(T.nilable(Integer)) }
        attr_reader :limit

        sig { params(limit: Integer).void }
        attr_writer :limit

        # Optional metadata filter. To filter, use the syntax `metadata[k]=v`. Omitting
        # the parameter or passing an empty object applies no metadata filter. An empty
        # value, such as `metadata[k]=`, filters for that key with an empty string value.
        # To select jobs with null metadata, send the literal query string
        # `metadata=null`. Nullable caller types do not specify how a client serializes
        # null for a deep-object parameter. Use a raw query parameter if the client omits
        # null. Do not combine the two query forms.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        sig do
          params(

            after: String,

            limit: Integer,

            metadata: T.nilable(T::Hash[Symbol, String]),

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Identifier for the last job from the previous pagination request.
          after: nil,

          # Number of fine-tuning jobs to retrieve.
          limit: nil,

          # Optional metadata filter. To filter, use the syntax `metadata[k]=v`. Omitting
          # the parameter or passing an empty object applies no metadata filter. An empty
          # value, such as `metadata[k]=`, filters for that key with an empty string value.
          # To select jobs with null metadata, send the literal query string
          # `metadata=null`. Nullable caller types do not specify how a client serializes
          # null for a deep-object parameter. Use a raw query parameter if the client omits
          # null. Do not combine the two query forms.
          metadata: nil,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              after: String,
              limit: Integer,
              metadata: T.nilable(T::Hash[Symbol, String]),
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
