# typed: strong

module OpenAI
  module Resources

    class Skills

      sig { returns(OpenAI::Resources::Skills::Content) }
      attr_reader :content

      sig { returns(OpenAI::Resources::Skills::Versions) }
      attr_reader :versions

      # Create a new skill.
      sig {
        params(files: OpenAI::SkillCreateParams::Files::Variants, request_options: OpenAI::RequestOptions::OrHash)
          .returns(OpenAI::Skill)
      }
      def create(
        # Skill files to upload (directory upload) or a single zip file.
        #
        # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        # metadata. Use `OpenAI::FilePart` when you need to override the filename or
        # content type.
        files: nil,
        request_options: {}
      )
      end

      # Get a skill by its ID.
      sig { params(skill_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::Skill) }
      def retrieve(
        # The identifier of the skill to retrieve.
        skill_id,
        request_options: {}
      )
      end

      # Update the default version pointer for a skill.
      sig {
        params(skill_id: String, default_version: String, request_options: OpenAI::RequestOptions::OrHash).returns(
          OpenAI::Skill
        )
      }
      def update(
        # The identifier of the skill.
        skill_id,
        # The skill version number to set as default.
        default_version:,
        request_options: {}
      )
      end

      # List all skills for the current project.
      sig {
        params(
          after: String,
          limit: Integer,
          order: OpenAI::SkillListParams::Order::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(OpenAI::Internal::CursorPage[OpenAI::Skill])
      }
      def list(
        # Identifier for the last item from the previous pagination request
        after: nil,
        # Number of items to retrieve
        limit: nil,
        # Sort order of results by timestamp. Use `asc` for ascending order or `desc` for
        # descending order.
        order: nil,
        request_options: {}
      )
      end

      # Delete a skill by its ID.
      sig { params(skill_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::DeletedSkill) }
      def delete(
        # The identifier of the skill to delete.
        skill_id,
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
