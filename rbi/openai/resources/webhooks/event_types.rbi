# typed: strong

module OpenAI
  module Resources

    class Webhooks

      class EventTypes

        # Returns webhook event types visible to the authenticated project.
        sig { params(request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::Webhooks::WebhookEventTypeList) }
        def list(request_options: {})
        end

        # @api private
        sig { params(client: OpenAI::Client).returns(T.attached_class) }
        def self.new(client:)
        end
      end

    end

  end
end
