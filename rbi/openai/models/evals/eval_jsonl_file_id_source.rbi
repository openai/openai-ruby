# typed: strong

module OpenAI
  module Models
    EvalJSONLFileIDSource = Evals::EvalJSONLFileIDSource

    module Evals
      class EvalJSONLFileIDSource < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Evals::EvalJSONLFileIDSource,
              OpenAI::Internal::AnyHash
            )
          end

        # The identifier of the file.
        sig { returns(String) }
        attr_accessor :id

        # The type of jsonl source. Always `file_id`.
        sig { returns(Symbol) }
        attr_accessor :type

        sig { params(id: String, type: Symbol).returns(T.attached_class) }
        def self.new(
          # The identifier of the file.
          id:,
          # The type of jsonl source. Always `file_id`.
          type: :file_id
        )
        end

        sig { override.returns({ id: String, type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
