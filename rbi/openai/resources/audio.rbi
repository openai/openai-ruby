# typed: strong

module OpenAI
  module Resources
    class Audio
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
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
