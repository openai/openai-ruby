# frozen_string_literal: true

module OpenAI
  module Resources
    class Skills
      class Content
        # Get Skill Content
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
            options: params[:request_options]
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
