# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class DataRetention
          sig { returns(DataRetention::WithRawResponse) }
          def with_raw_response
          end

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
          sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
          def self.new(client:)
          end

          class WithRawResponse
            sig { params(request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Admin::Organization::OrganizationDataRetention]) }
            def retrieve(request_options: {})
            end

            sig { params(retention_type: OpenAI::Admin::Organization::DataRetentionUpdateParams::RetentionType::OrSymbol, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[OpenAI::Admin::Organization::OrganizationDataRetention]) }
            def update(
              # The desired organization data retention type.
              retention_type:,
              request_options: {}
            )
            end

            # @api private
            sig { params(resource: DataRetention).returns(T.attached_class) }
            def self.new(resource:)
            end
          end
        end
      end
    end
  end
end
