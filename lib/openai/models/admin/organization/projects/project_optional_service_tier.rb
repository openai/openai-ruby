# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          module ProjectOptionalServiceTier
            extend OpenAI::Internal::Type::Enum

            FLEX = :flex
            FAST = :fast
            ULTRAFAST = :ultrafast

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        ProjectOptionalServiceTier = Projects::ProjectOptionalServiceTier
      end
    end
  end
end
