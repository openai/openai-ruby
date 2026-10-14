# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        # @see OpenAI::Resources::Beta::Threads::Messages#delete
        class MessageDeleted < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #
          #   @return [String]
          required :id, String

          # @!attribute deleted
          #
          #   @return [Boolean]
          required :deleted, OpenAI::Internal::Type::Boolean

          # @!attribute object
          #
          #   @return [Symbol, :"thread.message.deleted"]
          required :object, const: :"thread.message.deleted"

          # @!method initialize(id:, deleted:, object: :"thread.message.deleted")
          #   @param id [String]
          #   @param deleted [Boolean]
          #   @param object [Symbol, :"thread.message.deleted"]
        end
      end
    end
  end
end
