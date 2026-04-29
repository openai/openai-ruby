# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        # List user actions and configuration changes within this organization.
        # @return [OpenAI::Resources::Admin::Organization::AuditLogs]
        attr_reader :audit_logs

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @audit_logs = OpenAI::Resources::Admin::Organization::AuditLogs.new(client: client)
        end
      end
    end
  end
end
