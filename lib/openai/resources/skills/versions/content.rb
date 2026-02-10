# frozen_string_literal: true

module OpenAI
  module Resources
    class Skills
      class Versions
        class Content
          # Get Skill Version Content
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
              options: options
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
end
