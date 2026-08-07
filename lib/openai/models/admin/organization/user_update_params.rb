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

          # @!attribute developer_persona
          #   Developer persona metadata.
          #
          #   @return [String, nil]
          optional :developer_persona, String, nil?: true

          # @!attribute role
          #   `owner` or `reader`
          #
          #   @return [String, nil]
          optional :role, String, nil?: true

          # @!attribute role_id
          #   Role ID to assign to the user.
          #
          #   @return [String, nil]
          optional :role_id, String, nil?: true

          # @!attribute technical_level
          #   Technical level metadata.
          #
          #   @return [String, nil]
          optional :technical_level, String, nil?: true

          # @!method initialize(user_id:, developer_persona: nil, role: nil, role_id: nil, technical_level: nil, request_options: {})
          #   @param user_id [String]
          #
          #   @param developer_persona [String, nil] Developer persona metadata.
          #
          #   @param role [String, nil] `owner` or `reader`
          #
          #   @param role_id [String, nil] Role ID to assign to the user.
          #
          #   @param technical_level [String, nil] Technical level metadata.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
