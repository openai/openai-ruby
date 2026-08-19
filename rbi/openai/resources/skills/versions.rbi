# typed: strong

module OpenAI
  module Resources

    class Skills

      class Versions

        sig { returns(OpenAI::Resources::Skills::Versions::Content) }
        attr_reader :content

        # Create a new immutable skill version.
        sig {
          params(
            skill_id: String,
            default: T::Boolean,
            files: OpenAI::Skills::VersionCreateParams::Files::Variants,
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::Skills::SkillVersion)
        }
        def create(
          # The identifier of the skill to version.
          skill_id,
          # Whether to set this version as the default.
          default: nil,
          # Skill files to upload (directory upload) or a single zip file.
          #
          # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
          # metadata. Use `OpenAI::FilePart` when you need to override the filename or
          # content type.
          files: nil,
          request_options: {}
        )
        end

        # Get a specific skill version.
        sig {
          params(version: String, skill_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
            OpenAI::Skills::SkillVersion
          )
        }
        def retrieve(
          # The version number to retrieve.
          version,
          # The identifier of the skill.
          skill_id:,
          request_options: {}
        )
        end

        # List skill versions for a skill.
        sig {
          params(
            skill_id: String,
            after: String,
            limit: Integer,
            order: OpenAI::Skills::VersionListParams::Order::OrSymbol,
            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(OpenAI::Internal::CursorPage[OpenAI::Skills::SkillVersion])
        }
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

        # Delete a skill version.
        sig {
          params(version: String, skill_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
            OpenAI::Skills::DeletedSkillVersion
          )
        }
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
