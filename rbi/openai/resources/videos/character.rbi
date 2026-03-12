# typed: strong

module OpenAI
  module Resources
    class Videos
      class Character
        # Create a character from an uploaded video.
        sig do
          params(
            name: String,
            video: OpenAI::Internal::FileInput,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Models::Videos::CharacterCreateResponse)
        end
        def create(
          # Display name for this API character.
          name:,
          # Video file used to create a character.
          video:,
          request_options: {}
        )
        end

        # Fetch a character.
        sig do
          params(
            character_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Models::Videos::CharacterGetResponse)
        end
        def get(
          # The identifier of the character to retrieve.
          character_id,
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
