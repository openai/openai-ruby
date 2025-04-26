# typed: strong

module OpenAI
  module Models
    module FineTuning
      class JobListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

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

        # Optional metadata filter. To filter, use the syntax `metadata[k]=v`.
        # Alternatively, set `metadata=null` to indicate no metadata.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        sig do
          params(
            after: String,
            limit: Integer,
            metadata: T.nilable(T::Hash[Symbol, String]),
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(
          # Identifier for the last job from the previous pagination request.
          after: nil,
          # Number of fine-tuning jobs to retrieve.
          limit: nil,
          # Optional metadata filter. To filter, use the syntax `metadata[k]=v`.
          # Alternatively, set `metadata=null` to indicate no metadata.
          metadata: nil,
          request_options: {}
        ); end
        sig do
          override
            .returns(
              {
                after: String,
                limit: Integer,
                metadata: T.nilable(T::Hash[Symbol, String]),
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash; end
      end
    end
  end
end
