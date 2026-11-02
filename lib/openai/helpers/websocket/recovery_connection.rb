# frozen_string_literal: true

module OpenAI
  module WebSocket
    # Optional recovery I/O shared by the selected product facades. Their codecs
    # and public role methods remain owned by those facades.
    #
    # @api private
    module RecoveryConnection
      def receive
        return super unless @recovery

        receive_recovered_event
      end

      # @api private
      def update_recovery_url(url)
        @url = URI(url.to_s)
        nil
      end

      def reconnecting? = @recovery ? @recovery.reconnecting? : false

      def pending_messages = @recovery ? @recovery.pending_messages : []

      def take_pending_messages = @recovery ? @recovery.take_pending_messages : []

      def flush_pending
        @recovery&.flush_pending
        nil
      end

      private def read_raw_message
        @recovery ? @recovery.read : super
      end

      private def write_text(text)
        return super unless @recovery

        @recovery.write(text)
        nil
      end

      private def receive_recovered_event
        @recovery.read do |data|
          event = parse_event(data)
          [event, recovery_application_progress?(event)]
        end
      end

      private def recovery_application_progress?(event)
        return false unless event.is_a?(OpenAI::Internal::Type::BaseModel)

        type = event.type.to_s
        return false unless positive_recovery_event_type?(type)
        return false if event.respond_to?(:response) && failed_recovery_response?(event.response)

        true
      end

      private def positive_recovery_event_type?(type)
        !["error", "info", "rate_limits.updated"].include?(type) &&
          !type.end_with?(".failed", ".closed", ".incomplete", ".cancelled")
      end

      private def failed_recovery_response?(response)
        status = if response.is_a?(Hash)
          response[:status] || response["status"]
        elsif response.respond_to?(:status)
          response.status
        end

        ["failed", "incomplete", "cancelled"].include?(status.to_s)
      end
    end
  end
end
