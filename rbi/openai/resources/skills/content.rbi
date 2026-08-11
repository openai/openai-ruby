# typed: strong

module OpenAI
  module Resources
    class Skills
      class Content
        sig { returns(Content::WithRawResponse) }
        def with_raw_response
        end

        # Download a skill zip bundle by its ID.
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
        sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
        def self.new(client:)
        end

        class WithRawResponse
          sig { params(skill_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[StringIO]) }
          def retrieve(
            # The identifier of the skill to download.
            skill_id,
            request_options: {}
          )
          end

          # @api private
          sig { params(resource: Content).returns(T.attached_class) }
          def self.new(resource:)
          end
        end
      end
    end
  end
end
