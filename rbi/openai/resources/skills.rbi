# typed: strong

module OpenAI
  module Resources
    class Skills
      sig { returns(OpenAI::Resources::Skills::Content) }
      attr_reader :content

      sig { returns(OpenAI::Resources::Skills::Versions) }
      attr_reader :versions

      # Create Skill
      sig do
        params(
          files: OpenAI::SkillCreateParams::Files::Variants,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Skill)
      end
      def create(
        # Skill files to upload (directory upload) or a single zip file.
        files: nil,
        request_options: {}
      )
      end

      # Get Skill
      sig do
        params(
          skill_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Skill)
      end
      def retrieve(
        # The identifier of the skill to retrieve.
        skill_id,
        request_options: {}
      )
      end

      # Update Skill Default Version
      sig do
        params(
          skill_id: String,
          default_version: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Skill)
      end
      def update(
        # The identifier of the skill.
        skill_id,
        # The skill version number to set as default.
        default_version:,
        request_options: {}
      )
      end

      # List Skills
      sig do
        params(
          after: String,
          limit: Integer,
          order: OpenAI::SkillListParams::Order::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Internal::CursorPage[OpenAI::Skill])
      end
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

      # Delete Skill
      sig do
        params(
          skill_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::DeletedSkill)
      end
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
