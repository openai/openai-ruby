# typed: strong

module OpenAI
  module Models
    SkillVersionList = Skills::SkillVersionList

    module Skills
      class SkillVersionList < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Skills::SkillVersionList, OpenAI::Internal::AnyHash)
          end

        # A list of items
        sig { returns(T::Array[OpenAI::Skills::SkillVersion]) }
        attr_accessor :data

        # The ID of the first item in the list.
        sig { returns(T.nilable(String)) }
        attr_accessor :first_id

        # Whether there are more items available.
        sig { returns(T::Boolean) }
        attr_accessor :has_more

        # The ID of the last item in the list.
        sig { returns(T.nilable(String)) }
        attr_accessor :last_id

        # The type of object returned, must be `list`.
        sig { returns(Symbol) }
        attr_accessor :object

        sig do
          params(
            data: T::Array[OpenAI::Skills::SkillVersion::OrHash],
            first_id: T.nilable(String),
            has_more: T::Boolean,
            last_id: T.nilable(String),
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A list of items
          data:,
          # The ID of the first item in the list.
          first_id:,
          # Whether there are more items available.
          has_more:,
          # The ID of the last item in the list.
          last_id:,
          # The type of object returned, must be `list`.
          object: :list
        )
        end

        sig do
          override.returns(
            {
              data: T::Array[OpenAI::Skills::SkillVersion],
              first_id: T.nilable(String),
              has_more: T::Boolean,
              last_id: T.nilable(String),
              object: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
