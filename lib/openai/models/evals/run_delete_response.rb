# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      # @see OpenAI::Resources::Evals::Runs#delete
      class RunDeleteResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute deleted
        #
        #   @return [Boolean, nil]
        optional :deleted, OpenAI::Internal::Type::Boolean

        # @!attribute object
        #
        #   @return [String, nil]
        optional :object, String

        # @!attribute run_id
        #
        #   @return [String, nil]
        optional :run_id, String

        # @!method initialize(deleted: nil, object: nil, run_id: nil)
        #   @param deleted [Boolean]
        #   @param object [String]
        #   @param run_id [String]
      end
    end
  end
end
