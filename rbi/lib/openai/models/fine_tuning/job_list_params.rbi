# typed: strong

module OpenAI
  module Models
    module FineTuning
      class JobListParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # Identifier for the last job from the previous pagination request.
        sig { returns(T.nilable(String)) }
        def after
        end

        sig { params(_: String).returns(String) }
        def after=(_)
        end

        # Number of fine-tuning jobs to retrieve.
        sig { returns(T.nilable(Integer)) }
        def limit
        end

        sig { params(_: Integer).returns(Integer) }
        def limit=(_)
        end

        # Optional metadata filter. To filter, use the syntax `metadata[k]=v`.
        #   Alternatively, set `metadata=null` to indicate no metadata.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        def metadata
        end

        sig { params(_: T.nilable(T::Hash[Symbol, String])).returns(T.nilable(T::Hash[Symbol, String])) }
        def metadata=(_)
        end

        sig do
          params(
            after: String,
            limit: Integer,
            metadata: T.nilable(T::Hash[Symbol, String]),
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(after: nil, limit: nil, metadata: nil, request_options: {})
        end

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
        def to_hash
        end
      end
    end
  end
end
