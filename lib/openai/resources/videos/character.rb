# frozen_string_literal: true

module OpenAI
  module Resources
    class Videos
      class Character
        # Create a character from an uploaded video.
        #
        # @overload create(name:, video:, request_options: {})
        #
        # @param name [String] Display name for this API character.
        #
        # @param video [Pathname, StringIO, IO, String, OpenAI::FilePart] Video file used to create a character.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Videos::CharacterCreateResponse]
        #
        # @see OpenAI::Models::Videos::CharacterCreateParams
        def create(params)
          parsed, options = OpenAI::Videos::CharacterCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: "videos/characters",
            headers: {"content-type" => "multipart/form-data"},
            body: parsed,
            model: OpenAI::Models::Videos::CharacterCreateResponse,
            options: options
          )
        end

        # Fetch a character.
        #
        # @overload get(character_id, request_options: {})
        #
        # @param character_id [String] The identifier of the character to retrieve.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Videos::CharacterGetResponse]
        #
        # @see OpenAI::Models::Videos::CharacterGetParams
        def get(character_id, params = {})
          @client.request(
            method: :get,
            path: ["videos/characters/%1$s", character_id],
            model: OpenAI::Models::Videos::CharacterGetResponse,
            options: params[:request_options]
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
