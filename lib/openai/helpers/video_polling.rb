# frozen_string_literal: true

module OpenAI
  module Resources
    class Videos
      # Create a video and wait for it to reach a terminal state.
      #
      # @overload create_and_poll(prompt:, input_reference: nil, model: nil, seconds: nil, size: nil, poll_interval: nil, request_options: {})
      #
      # @param prompt [String] Text prompt that describes the video to generate.
      #
      # @param input_reference [Pathname, StringIO, IO, String, OpenAI::FilePart, OpenAI::Models::ImageInputReferenceParam, nil] Optional reference asset upload or reference object that guides generation.
      #
      # @param model [String, Symbol, OpenAI::Models::VideoModel, nil] The video generation model to use.
      #
      # @param seconds [Symbol, OpenAI::Models::VideoSeconds, nil] Clip duration in seconds.
      #
      # @param size [Symbol, OpenAI::Models::VideoSize, nil] Output resolution formatted as width x height.
      #
      # @param poll_interval [Numeric, nil] Seconds between status requests. Defaults to one second.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Video]
      def create_and_poll(params)
        params = params.to_h.dup
        poll_interval = params.delete(:poll_interval)
        poll_interval = normalize_poll_interval(poll_interval) unless poll_interval.nil?
        request_options = params[:request_options]
        video = create(params)

        poll(video.id, poll_interval: poll_interval, request_options: request_options)
      end

      # Wait for a video to reach a terminal state.
      #
      # Returns videos in either the `completed` or `failed` state. API request errors
      # are raised normally.
      #
      # @param video_id [String] The identifier of the video to poll.
      #
      # @param poll_interval [Numeric, nil] Seconds between status requests. Defaults to one second.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Video]
      def poll(video_id, poll_interval: nil, request_options: {})
        poll_interval = normalize_poll_interval(poll_interval) unless poll_interval.nil?
        request_options = polling_request_options(request_options, poll_interval: poll_interval)
        poll_interval ||= 1.0

        loop do
          video = retrieve(video_id, request_options: request_options)
          return video unless [:queued, :in_progress].include?(video.status)

          sleep(poll_interval)
        end
      end

      # @api private
      private def normalize_poll_interval(poll_interval)
        poll_interval = Float(poll_interval)
        return poll_interval if poll_interval.finite? && poll_interval >= 0

        raise ArgumentError, "poll_interval must be a finite, non-negative number"
      end

      # @api private
      private def polling_request_options(request_options, poll_interval:)
        request_options = request_options.to_h
        polling_headers = {"x-stainless-poll-helper" => "true"}
        unless poll_interval.nil?
          polling_headers["x-stainless-custom-poll-interval"] = (poll_interval * 1000).to_i.to_s
        end
        headers = request_options[:extra_headers].to_h.merge(polling_headers)
        request_options.merge(extra_headers: headers)
      end
    end
  end
end
