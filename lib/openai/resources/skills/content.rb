# frozen_string_literal: true

module OpenAI
  module Resources
    class Skills
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

        # Download a skill zip bundle by its ID.
        #
        # @overload retrieve(skill_id, request_options: {})
        #
        # @param skill_id [String] The identifier of the skill to download.
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [StringIO]
        #
        # @see OpenAI::Models::Skills::ContentRetrieveParams
        def retrieve(skill_id, params = {})
          @client.request(
            method: :get,
            path: ["skills/%1$s/content", skill_id],
            headers: {"accept" => "application/binary"},
            model: StringIO,
            security: {bearer_auth: true},
            options: params[:request_options]
          )
        end

        # @api private
        #
        # @param client [OpenAI::Internal::Transport::RequestClient]
        def initialize(client:)
          @client = client
        end

        class WithRawResponse
          def retrieve(skill_id, params = {})
            @resource.retrieve(skill_id, params)
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
