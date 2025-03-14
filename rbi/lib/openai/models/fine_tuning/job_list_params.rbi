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

        sig do
          params(
            after: String,
            limit: Integer,
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(after: nil, limit: nil, request_options: {})
        end

        sig { override.returns({after: String, limit: Integer, request_options: OpenAI::RequestOptions}) }
        def to_hash
        end
      end
    end
  end
end
