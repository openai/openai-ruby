# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class AdminAPIKeyDeleteResponse < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Admin::Organization::AdminAPIKeyDeleteResponse,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(T.nilable(String)) }
          attr_reader :id

          sig { params(id: String).void }
          attr_writer :id

          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :deleted

          sig { params(deleted: T::Boolean).void }
          attr_writer :deleted

          sig { returns(T.nilable(String)) }
          attr_reader :object

          sig { params(object: String).void }
          attr_writer :object

          sig do
            params(id: String, deleted: T::Boolean, object: String).returns(
              T.attached_class
            )
          end
          def self.new(id: nil, deleted: nil, object: nil)
          end

          sig do
            override.returns(
              { id: String, deleted: T::Boolean, object: String }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
