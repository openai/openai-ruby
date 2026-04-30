# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Users#update
        class UserUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute user_id
          #
          #   @return [String]
          required :user_id, String

          # @!attribute role
          #   `owner` or `reader`
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::UserUpdateParams::Role]
          required :role, enum: -> { OpenAI::Admin::Organization::UserUpdateParams::Role }

          # @!method initialize(user_id:, role:, request_options: {})
          #   @param user_id [String]
          #
          #   @param role [Symbol, OpenAI::Models::Admin::Organization::UserUpdateParams::Role] `owner` or `reader`
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # `owner` or `reader`
          module Role
            extend OpenAI::Internal::Type::Enum

            OWNER = :owner
            READER = :reader

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
