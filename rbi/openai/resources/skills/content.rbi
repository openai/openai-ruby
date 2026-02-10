# typed: strong

module OpenAI
  module Resources
    class Skills
      class Content
        # Get Skill Content
        sig do
          params(
            skill_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(StringIO)
        end
        def retrieve(
          # The identifier of the skill to download.
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
end
