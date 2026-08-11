# frozen_string_literal: true

module OpenAI
  module Resources
    class Skills
      class Versions
        class Content
          # Returns a wrapper that exposes the raw HTTP response for each request.
          #
          # @return [Content::WithRawResponse]
          def with_raw_response
            WithRawResponse.new(
              resource: Content.new(
                client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
              )
            )
          end

          # Download a skill version zip bundle.
          #
          # @overload retrieve(version, skill_id:, request_options: {})
          #
          # @param version [String] The skill version number.
          #
          # @param skill_id [String] The identifier of the skill.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [StringIO]
          #
          # @see OpenAI::Models::Skills::Versions::ContentRetrieveParams
          def retrieve(version, params)
            parsed, options = OpenAI::Skills::Versions::ContentRetrieveParams.dump_request(params)
            skill_id =
              parsed.delete(:skill_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :get,
              path: ["skills/%1$s/versions/%2$s/content", skill_id, version],
              headers: {"accept" => "application/binary"},
              model: StringIO,
              security: {bearer_auth: true},
              options: options
            )
          end

          # @api private
          #
          # @param client [OpenAI::Internal::Transport::RequestClient]
          def initialize(client:)
            @client = client
          end

          class WithRawResponse
            def retrieve(version, params)
              @resource.retrieve(version, params)
            end

            # @api private
            #
            # @param resource [Content]
            def initialize(resource:)
              @resource = resource
            end
          end
        end
      end
    end
  end
end
