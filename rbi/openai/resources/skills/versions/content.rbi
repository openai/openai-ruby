# typed: strong

module OpenAI
  module Resources
    class Skills
      class Versions
        class Content
          # Get Skill Version Content
          sig do
            params(
              version: String,
              skill_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(StringIO)
          end
          def retrieve(
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
end
