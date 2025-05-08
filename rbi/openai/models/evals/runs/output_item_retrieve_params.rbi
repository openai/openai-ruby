# typed: strong

module OpenAI
  module Models
    module Evals
      module Runs
        class OutputItemRetrieveParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          sig { returns(String) }
          attr_accessor :eval_id

          sig { returns(String) }
          attr_accessor :run_id

          sig do
            params(
              eval_id: String,
              run_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(eval_id:, run_id:, request_options: {})
          end

          sig do
            override.returns(
              {
                eval_id: String,
                run_id: String,
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
end
