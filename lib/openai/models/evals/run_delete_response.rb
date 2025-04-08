# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      # @see OpenAI::Resources::Evals::Runs#delete
      class RunDeleteResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute [r] deleted
        #
        #   @return [Boolean, nil]
        optional :deleted, OpenAI::Internal::Type::Boolean

        # @!parse
        #   # @return [Boolean]
        #   attr_writer :deleted

        # @!attribute [r] object
        #
        #   @return [String, nil]
        optional :object, String

        # @!parse
        #   # @return [String]
        #   attr_writer :object

        # @!attribute [r] run_id
        #
        #   @return [String, nil]
        optional :run_id, String

        # @!parse
        #   # @return [String]
        #   attr_writer :run_id

        # @!parse
        #   # @param deleted [Boolean]
        #   # @param object [String]
        #   # @param run_id [String]
        #   #
        #   def initialize(deleted: nil, object: nil, run_id: nil, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
