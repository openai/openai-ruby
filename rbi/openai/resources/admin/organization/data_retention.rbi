# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class DataRetention
          # Retrieves organization data retention controls.
          sig do
            params(request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Admin::Organization::OrganizationDataRetention
            )
          end
          def retrieve(request_options: {})
          end

          # Updates organization data retention controls.
          sig do
            params(
              retention_type:
                OpenAI::Admin::Organization::DataRetentionUpdateParams::RetentionType::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Admin::Organization::OrganizationDataRetention)
          end
          def update(
            # The desired organization data retention type.
            retention_type:,
            request_options: {}
          )
          end

          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
