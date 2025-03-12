# typed: strong

module OpenAI
  module Models
    module FineTuning
      class JobListParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(T.nilable(String)) }
        def after
        end

        sig { params(_: String).returns(String) }
        def after=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def limit
        end

        sig { params(_: Integer).returns(Integer) }
        def limit=(_)
        end

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
