# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        # @see OpenAI::Resources::Beta::Threads::Messages#delete
        class MessageDeleted < OpenAI::BaseModel
          # @!attribute id
          #
          #   @return [String]
          required :id, String

          # @!attribute deleted
          #
          #   @return [Boolean]
          required :deleted, OpenAI::BooleanModel

          # @!attribute object
          #
          #   @return [Symbol, :"thread.message.deleted"]
          required :object, const: :"thread.message.deleted"

          # @!parse
          #   # @param id [String]
          #   # @param deleted [Boolean]
          #   # @param object [Symbol, :"thread.message.deleted"]
          #   #
          #   def initialize(id:, deleted:, object: :"thread.message.deleted", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end
  end
end
