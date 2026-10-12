# frozen_string_literal: true

require_relative "../resources/files"
require_relative "resource_polling"

module OpenAI
  module Resources
    class Files
      # Wait for an uploaded file to finish processing.
      #
      # The returned file may have an `error` status; callers should inspect the
      # status before using it. Polling intervals and the overall timeout are in
      # seconds. Finite timeouts include authentication and request replay time and
      # disable transport retries so the deadline remains strict. Set `timeout` to
      # `nil` to wait indefinitely and retain configured transport retries.
      #
      # @overload wait_for_processing(file_id, poll_interval: nil, timeout: 1800.0, request_options: {})
      #
      # @param file_id [String] The ID of the file to wait for.
      #
      # @param poll_interval [Integer, Float, nil] How often to retrieve the file. When omitted, the SDK honors the server's
      #   polling hint and otherwise waits 5 seconds.
      #
      # @param timeout [Integer, Float, nil] Maximum total time to poll. Defaults to 30 minutes. Set to `nil` to wait
      #   indefinitely.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @raise [ArgumentError, OpenAI::Errors::PollingError]
      # @return [OpenAI::Models::FileObject]
      def wait_for_processing(
        file_id,
        poll_interval: nil,
        timeout: OpenAI::Internal::Poller::DEFAULT_TIMEOUT,
        request_options: {}
      )
        OpenAI::Helpers::ResourcePolling.wait_for_file(
          self,
          file_id,
          poll_interval: poll_interval,
          timeout: timeout,
          request_options: request_options
        )
      end
    end
  end
end
