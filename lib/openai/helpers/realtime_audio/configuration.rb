# frozen_string_literal: true

module OpenAI
  module Realtime
    # @api private
    class AudioConfiguration
      DEFAULTS = {
        frame_duration: 0.02,
        input_buffer_duration: 0.25,
        output_buffer_duration: 0.10,
        control_timeout: 5.0,
        cleanup_timeout: 2.0,
        half_duplex_tail_duration: 0.15,
        playback_directory: nil,
        event_queue_capacity: nil
      }.freeze
      attr_reader :options, :session, :owned, :mode, :playback_policy

      def initialize(voice:, mode:, playback_policy:, turn_detection:, session:, audio_options:)
        unless [:server_vad, :semantic_vad, :push_to_talk].include?(mode)
          raise ArgumentError, "mode must be :server_vad, :semantic_vad, or :push_to_talk"
        end

        unless [:duplex, :half_duplex].include?(playback_policy)
          raise ArgumentError, "playback_policy must be :duplex or :half_duplex"
        end

        raise ArgumentError, "voice must be a nonempty String" unless voice.is_a?(String) && !voice.empty?
        @mode, @playback_policy = mode, playback_policy
        @options = DEFAULTS.merge(symbolize(audio_options))
        raise ArgumentError, "Unknown audio option" unless (@options.keys - DEFAULTS.keys).empty?
        DEFAULTS.each_key do |key|
          next if [:playback_directory, :event_queue_capacity].include?(key)
          next if key == :half_duplex_tail_duration && @options[key] == 0
          @options[key] = LocalAudio::MediaProcess.duration(@options[key], name: key)
        end

        LocalAudio.frame_samples(@options[:frame_duration])
        capacity = @options[:event_queue_capacity]
        unless capacity.nil? || (capacity.is_a?(Integer) && capacity.positive?)
          raise ArgumentError, "event_queue_capacity must be a positive Integer or nil"
        end

        directory = @options[:playback_directory]
        if directory
          raise ArgumentError, "playback_directory must be a directory path" unless directory.is_a?(String)
          @options[:playback_directory] = File.realpath(directory)
          raise ArgumentError, "playback_directory must be a directory" unless File.directory?(directory)
        end

        detection = symbolize(turn_detection)
        allowed = {
          server_vad: [:threshold, :prefix_padding_ms, :silence_duration_ms],
          semantic_vad: [:eagerness],
          push_to_talk: []
        }.fetch(mode)
        unless (detection.keys - allowed).empty?
          raise ArgumentError, "Unsupported or helper-owned turn_detection option"
        end

        detection = mode == :push_to_talk ? nil : detection.merge(
          type: mode.to_s,
          create_response: false,
          interrupt_response: false
        )
        pcm = {type: "audio/pcm", rate: 24_000}
        @owned = {
          type: "realtime",
          output_modalities: ["audio"],
          audio: {input: {format: pcm, turn_detection: detection}, output: {format: pcm, voice: voice}}
        }
        @session = merge_owned(symbolize(session), @owned)
        effective_detection = @session.dig(:audio, :input, :turn_detection)
        if effective_detection &&
            !(effective_detection.keys - allowed - [:type, :create_response, :interrupt_response]).empty?
          raise ArgumentError, "Unsupported nested turn_detection option"
        end
      end

      def compatible?(actual, expected = @owned)
        expected.all? do |key, value|
          next false unless actual.key?(key)
          other = actual[key]
          value.is_a?(Hash) ? other.is_a?(Hash) && compatible?(other, value) : other == value
        end
      end

      def inspect = "#<OpenAI::Realtime::AudioConfiguration>"

      private def symbolize(value)
        raise ArgumentError, "Options must be a Hash" unless value.is_a?(Hash)
        value.each_with_object({}) do |(key, item), result|
          raise ArgumentError, "Option keys must be strings or symbols" unless key.is_a?(String) || key.is_a?(Symbol)
          key = key.to_sym
          raise ArgumentError, "Duplicate option key" if result.key?(key)
          result[key] = item.is_a?(Hash) ? symbolize(item) : item
        end
      end

      private def merge_owned(user, owned)
        result = user.dup
        owned.each do |key, value|
          if result.key?(key)
            if value.is_a?(Hash) && result[key].is_a?(Hash)
              result[key] = merge_owned(result[key], value)
            elsif result[key] != value
              raise ArgumentError, "Session configuration conflicts with a helper-owned field"
            end
          else
            result[key] = value
          end
        end

        result
      end
    end
  end
end
