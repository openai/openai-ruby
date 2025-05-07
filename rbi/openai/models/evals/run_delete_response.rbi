# typed: strong

module OpenAI
  module Models
    module Evals
      class RunDeleteResponse < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :deleted

        sig { params(deleted: T::Boolean).void }
        attr_writer :deleted

        sig { returns(T.nilable(String)) }
        attr_reader :object

        sig { params(object: String).void }
        attr_writer :object

        sig { returns(T.nilable(String)) }
        attr_reader :run_id

        sig { params(run_id: String).void }
        attr_writer :run_id

        sig do
          params(deleted: T::Boolean, object: String, run_id: String).returns(
            T.attached_class
          )
        end
        def self.new(deleted: nil, object: nil, run_id: nil)
        end

        sig do
          override.returns(
            { deleted: T::Boolean, object: String, run_id: String }
          )
        end
        def to_hash
        end
      end
    end
  end
end
