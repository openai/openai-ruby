# typed: strong

module OpenAI
  module Models
    module FineTuning
      class JobResumeParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::FineTuning::JobResumeParams,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(String) }
        attr_accessor :fine_tuning_job_id

        sig do
          params(
            fine_tuning_job_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(fine_tuning_job_id:, request_options: {})
        end

        sig do
          override.returns(
            {
              fine_tuning_job_id: String,
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
