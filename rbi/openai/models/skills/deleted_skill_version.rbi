# typed: strong

module OpenAI
  module Models
    module Skills
      class DeletedSkillVersion < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Skills::DeletedSkillVersion,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(String) }
        attr_accessor :id

        sig { returns(T::Boolean) }
        attr_accessor :deleted

        sig { returns(Symbol) }
        attr_accessor :object

        # The deleted skill version.
        sig { returns(String) }
        attr_accessor :version

        sig do
          params(
            id: String,
            deleted: T::Boolean,
            version: String,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          id:,
          deleted:,
          # The deleted skill version.
          version:,
          object: :"skill.version.deleted"
        )
        end

        sig do
          override.returns(
            { id: String, deleted: T::Boolean, object: Symbol, version: String }
          )
        end
        def to_hash
        end
      end
    end
  end
end
