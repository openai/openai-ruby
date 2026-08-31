# typed: strong

module OpenAI
  module Resources

    class Skills

      class Content

        # Download a skill zip bundle by its ID.
        sig do
          params(skill_id: String, request_options: OpenAI::RequestOptions::OrHash)
            .returns(T.all(StringIO, OpenAI::ResponseCarrier))
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
