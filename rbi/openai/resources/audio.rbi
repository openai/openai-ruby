# typed: strong

module OpenAI
  module Resources
    class Audio
      sig { returns(Audio::WithRawResponse) }
      def with_raw_response
      end

      # Turn audio into text or text into audio.
      sig { returns(OpenAI::Resources::Audio::Transcriptions) }
      attr_reader :transcriptions

      # Turn audio into text or text into audio.
      sig { returns(OpenAI::Resources::Audio::Translations) }
      attr_reader :translations

      # Turn audio into text or text into audio.
      sig { returns(OpenAI::Resources::Audio::Speech) }
      attr_reader :speech

      # @api private
      sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
      def self.new(client:)
      end

      class WithRawResponse
        sig { returns(OpenAI::Resources::Audio::Transcriptions::WithRawResponse) }
        attr_reader :transcriptions

        sig { returns(OpenAI::Resources::Audio::Translations::WithRawResponse) }
        attr_reader :translations

        sig { returns(OpenAI::Resources::Audio::Speech::WithRawResponse) }
        attr_reader :speech

        # @api private
        sig { params(resource: Audio).returns(T.attached_class) }
        def self.new(resource:)
        end
      end
    end
  end
end
