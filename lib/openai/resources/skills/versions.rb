# frozen_string_literal: true

module OpenAI
  module Resources
    class Skills
      class Versions
        # @return [OpenAI::Resources::Skills::Versions::Content]
        attr_reader :content

        # Create Skill Version
        #
        # @overload create(skill_id, default: nil, files: nil, request_options: {})
        #
        # @param skill_id [String] The identifier of the skill to version.
        #
        # @param default [Boolean] Whether to set this version as the default.
        #
        # @param files [Array<Pathname, StringIO, IO, String, OpenAI::FilePart>, Pathname, StringIO, IO, String, OpenAI::FilePart] Skill files to upload (directory upload) or a single zip file.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Skills::SkillVersion]
        #
        # @see OpenAI::Models::Skills::VersionCreateParams
        def create(skill_id, params = {})
          parsed, options = OpenAI::Skills::VersionCreateParams.dump_request(params)
          @client.request(
            method: :post,
            path: ["skills/%1$s/versions", skill_id],
            headers: {"content-type" => "multipart/form-data"},
            body: parsed,
            model: OpenAI::Skills::SkillVersion,
            options: options
          )
        end

        # Get Skill Version
        #
        # @overload retrieve(version, skill_id:, request_options: {})
        #
        # @param version [String] The version number to retrieve.
        #
        # @param skill_id [String] The identifier of the skill.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Skills::SkillVersion]
        #
        # @see OpenAI::Models::Skills::VersionRetrieveParams
        def retrieve(version, params)
          parsed, options = OpenAI::Skills::VersionRetrieveParams.dump_request(params)
          skill_id =
            parsed.delete(:skill_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :get,
            path: ["skills/%1$s/versions/%2$s", skill_id, version],
            model: OpenAI::Skills::SkillVersion,
            options: options
          )
        end

        # List Skill Versions
        #
        # @overload list(skill_id, after: nil, limit: nil, order: nil, request_options: {})
        #
        # @param skill_id [String] The identifier of the skill.
        #
        # @param after [String] The skill version ID to start after.
        #
        # @param limit [Integer] Number of versions to retrieve.
        #
        # @param order [Symbol, OpenAI::Models::Skills::VersionListParams::Order] Sort order of results by version number.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Skills::SkillVersion>]
        #
        # @see OpenAI::Models::Skills::VersionListParams
        def list(skill_id, params = {})
          parsed, options = OpenAI::Skills::VersionListParams.dump_request(params)
          @client.request(
            method: :get,
            path: ["skills/%1$s/versions", skill_id],
            query: parsed,
            page: OpenAI::Internal::CursorPage,
            model: OpenAI::Skills::SkillVersion,
            options: options
          )
        end

        # Delete Skill Version
        #
        # @overload delete(version, skill_id:, request_options: {})
        #
        # @param version [String] The skill version number.
        #
        # @param skill_id [String] The identifier of the skill.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Skills::DeletedSkillVersion]
        #
        # @see OpenAI::Models::Skills::VersionDeleteParams
        def delete(version, params)
          parsed, options = OpenAI::Skills::VersionDeleteParams.dump_request(params)
          skill_id =
            parsed.delete(:skill_id) do
              raise ArgumentError.new("missing required path argument #{_1}")
            end
          @client.request(
            method: :delete,
            path: ["skills/%1$s/versions/%2$s", skill_id, version],
            model: OpenAI::Skills::DeletedSkillVersion,
            options: options
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
          @content = OpenAI::Resources::Skills::Versions::Content.new(client: client)
        end
      end
    end
  end
end
