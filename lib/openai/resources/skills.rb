# frozen_string_literal: true

module OpenAI
  module Resources
    class Skills
      # @return [OpenAI::Resources::Skills::Content]
      attr_reader :content

      # @return [OpenAI::Resources::Skills::Versions]
      attr_reader :versions

      # Create Skill
      #
      # @overload create(files: nil, request_options: {})
      #
      # @param files [Array<Pathname, StringIO, IO, String, OpenAI::FilePart>, Pathname, StringIO, IO, String, OpenAI::FilePart] Skill files to upload (directory upload) or a single zip file.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Skill]
      #
      # @see OpenAI::Models::SkillCreateParams
      def create(params = {})
        parsed, options = OpenAI::SkillCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "skills",
          headers: {"content-type" => "multipart/form-data"},
          body: parsed,
          model: OpenAI::Skill,
          options: options
        )
      end

      # Get Skill
      #
      # @overload retrieve(skill_id, request_options: {})
      #
      # @param skill_id [String] The identifier of the skill to retrieve.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Skill]
      #
      # @see OpenAI::Models::SkillRetrieveParams
      def retrieve(skill_id, params = {})
        @client.request(
          method: :get,
          path: ["skills/%1$s", skill_id],
          model: OpenAI::Skill,
          options: params[:request_options]
        )
      end

      # Update Skill Default Version
      #
      # @overload update(skill_id, default_version:, request_options: {})
      #
      # @param skill_id [String] The identifier of the skill.
      #
      # @param default_version [String] The skill version number to set as default.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Skill]
      #
      # @see OpenAI::Models::SkillUpdateParams
      def update(skill_id, params)
        parsed, options = OpenAI::SkillUpdateParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["skills/%1$s", skill_id],
          body: parsed,
          model: OpenAI::Skill,
          options: options
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::SkillListParams} for more details.
      #
      # List Skills
      #
      # @overload list(after: nil, limit: nil, order: nil, request_options: {})
      #
      # @param after [String] Identifier for the last item from the previous pagination request
      #
      # @param limit [Integer] Number of items to retrieve
      #
      # @param order [Symbol, OpenAI::Models::SkillListParams::Order] Sort order of results by timestamp. Use `asc` for ascending order or `desc` for
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Skill>]
      #
      # @see OpenAI::Models::SkillListParams
      def list(params = {})
        parsed, options = OpenAI::SkillListParams.dump_request(params)
        @client.request(
          method: :get,
          path: "skills",
          query: parsed,
          page: OpenAI::Internal::CursorPage,
          model: OpenAI::Skill,
          options: options
        )
      end

      # Delete Skill
      #
      # @overload delete(skill_id, request_options: {})
      #
      # @param skill_id [String] The identifier of the skill to delete.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::DeletedSkill]
      #
      # @see OpenAI::Models::SkillDeleteParams
      def delete(skill_id, params = {})
        @client.request(
          method: :delete,
          path: ["skills/%1$s", skill_id],
          model: OpenAI::DeletedSkill,
          options: params[:request_options]
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @content = OpenAI::Resources::Skills::Content.new(client: client)
        @versions = OpenAI::Resources::Skills::Versions.new(client: client)
      end
    end
  end
end
