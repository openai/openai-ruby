# typed: strong

module OpenAI
  module Resources

    class Safety

      class Alerts

        # Get a safety alert belonging to the authenticated API project.
        sig {
          params(id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::Safety::SafetyAlert)
        }
        def retrieve(
          # Project safety alert ID
          id,
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
