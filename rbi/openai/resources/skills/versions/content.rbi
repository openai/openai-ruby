# typed: strong

module OpenAI
  module Resources
    class Skills
      class Versions
        class Content
          sig { returns(Content::WithRawResponse) }
          def with_raw_response
          end

          # Download a skill version zip bundle.
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
          sig { params(client: OpenAI::Internal::Transport::RequestClient).returns(T.attached_class) }
          def self.new(client:)
          end

          class WithRawResponse
            sig { params(version: String, skill_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(OpenAI::RawResponse[StringIO]) }
            def retrieve(
              # The skill version number.
              version,
              # The identifier of the skill.
              skill_id:,
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
end
