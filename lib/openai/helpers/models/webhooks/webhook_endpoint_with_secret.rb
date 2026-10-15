# frozen_string_literal: true

require_relative "../../../models/webhooks/webhook_endpoint_with_secret"

module OpenAI
  module Models
    module Webhooks
      class WebhookEndpointWithSecret
        # Keep diagnostics safe without changing field access or serialization.
        def to_s = deep_to_h.merge(signing_secret: "[REDACTED]").to_s

        def inspect
          converted = self.class.recursively_to_h(self, convert: true)
          converted[:signing_secret] = "[REDACTED]"
          "#<#{self.class}:0x#{object_id.to_s(16)} #{converted}>"
        end
      end
    end
  end
end
