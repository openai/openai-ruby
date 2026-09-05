# frozen_string_literal: true

module OpenAI
  module Internal
    module Type
      # Preserve response metadata behavior when callers duplicate a direct
      # binary response.
      #
      # @api private
      module DuplicableResponseCarrier
        # @api private
        #
        # @return [StringIO]
        def dup(...)
          super.tap do |copy|
            copy.extend(OpenAI::ResponseCarrier, OpenAI::Internal::Type::DuplicableResponseCarrier)
            copy._set_last_response(last_response)
          end
        end
      end
    end
  end
end
