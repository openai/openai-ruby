# typed: strong

module OpenAI
  module Resources
    class Audio
      sig { returns(OpenAI::Resources::Audio::Transcriptions) }
      def transcriptions
      end

      sig { returns(OpenAI::Resources::Audio::Translations) }
      def translations
      end

      sig { returns(OpenAI::Resources::Audio::Speech) }
      def speech
      end

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
