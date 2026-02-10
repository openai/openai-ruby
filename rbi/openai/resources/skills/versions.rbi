# typed: strong

module OpenAI
  module Resources
    class Skills
      class Versions
        sig { returns(OpenAI::Resources::Skills::Versions::Content) }
        attr_reader :content

        # Create Skill Version
        sig do
          params(
            skill_id: String,
            default: T::Boolean,
            files: OpenAI::Skills::VersionCreateParams::Files::Variants,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Skills::SkillVersion)
        end
        def create(
          # The identifier of the skill to version.
          skill_id,
          # Whether to set this version as the default.
          default: nil,
          # Skill files to upload (directory upload) or a single zip file.
          files: nil,
          request_options: {}
        )
        end

        # Get Skill Version
        sig do
          params(
            version: String,
            skill_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Skills::SkillVersion)
        end
        def retrieve(
          # The version number to retrieve.
          version,
          # The identifier of the skill.
          skill_id:,
          request_options: {}
        )
        end

        # List Skill Versions
        sig do
          params(
            skill_id: String,
            after: String,
            limit: Integer,
            order: OpenAI::Skills::VersionListParams::Order::OrSymbol,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Internal::CursorPage[OpenAI::Skills::SkillVersion])
        end
        def list(
          # The identifier of the skill.
          skill_id,
          # The skill version ID to start after.
          after: nil,
          # Number of versions to retrieve.
          limit: nil,
          # Sort order of results by version number.
          order: nil,
          request_options: {}
        )
        end

        # Delete Skill Version
        sig do
          params(
            version: String,
            skill_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Skills::DeletedSkillVersion)
        end
        def delete(
          # The skill version number.
          version,
          # The identifier of the skill.
          skill_id:,
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
