# typed: strong

module OpenAI
  module Models
    module Responses
      class ApplyPatchTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::ApplyPatchTool, OpenAI::Internal::AnyHash)
          end

        # The type of the tool. Always `apply_patch`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Allows the assistant to create, delete, or update files using unified diffs.
        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(
          # The type of the tool. Always `apply_patch`.
          type: :apply_patch
        )
        end

        sig { override.returns({ type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
