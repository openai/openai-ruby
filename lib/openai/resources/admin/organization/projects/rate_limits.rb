# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class RateLimits
            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Admin::Organization::Projects::RateLimitListRateLimitsParams}
            # for more details.
            #
            # Returns the rate limits per model for a project.
            #
            # @overload list_rate_limits(project_id, after: nil, before: nil, limit: nil, request_options: {})
            #
            # @param project_id [String] The ID of the project.
            #
            # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
            #
            # @param before [String] A cursor for use in pagination. `before` is an object ID that defines your place
            #
            # @param limit [Integer] A limit on the number of objects to be returned. The default is 100.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Admin::Organization::Projects::ProjectRateLimit>]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::RateLimitListRateLimitsParams
            def list_rate_limits(project_id, params = {})
              parsed, options =
                OpenAI::Admin::Organization::Projects::RateLimitListRateLimitsParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["organization/projects/%1$s/rate_limits", project_id],
                query: query,
                page: OpenAI::Internal::ConversationCursorPage,
                model: OpenAI::Admin::Organization::Projects::ProjectRateLimit,
                security: {admin_api_key_auth: true},
                options: options
              )
            end

            # Some parameter documentations has been truncated, see
            # {OpenAI::Models::Admin::Organization::Projects::RateLimitUpdateRateLimitParams}
            # for more details.
            #
            # Updates a project rate limit.
            #
            # @overload update_rate_limit(rate_limit_id, project_id:, batch_1_day_max_input_tokens: nil, max_audio_megabytes_per_1_minute: nil, max_images_per_1_minute: nil, max_requests_per_1_day: nil, max_requests_per_1_minute: nil, max_tokens_per_1_minute: nil, request_options: {})
            #
            # @param rate_limit_id [String] Path param: The ID of the rate limit.
            #
            # @param project_id [String] Path param: The ID of the project.
            #
            # @param batch_1_day_max_input_tokens [Integer] Body param: The maximum batch input tokens per day. Only relevant for certain mo
            #
            # @param max_audio_megabytes_per_1_minute [Integer] Body param: The maximum audio megabytes per minute. Only relevant for certain mo
            #
            # @param max_images_per_1_minute [Integer] Body param: The maximum images per minute. Only relevant for certain models.
            #
            # @param max_requests_per_1_day [Integer] Body param: The maximum requests per day. Only relevant for certain models.
            #
            # @param max_requests_per_1_minute [Integer] Body param: The maximum requests per minute.
            #
            # @param max_tokens_per_1_minute [Integer] Body param: The maximum tokens per minute.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Admin::Organization::Projects::ProjectRateLimit]
            #
            # @see OpenAI::Models::Admin::Organization::Projects::RateLimitUpdateRateLimitParams
            def update_rate_limit(rate_limit_id, params)
              parsed, options =
                OpenAI::Admin::Organization::Projects::RateLimitUpdateRateLimitParams.dump_request(params)
              project_id =
                parsed.delete(:project_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :post,
                path: ["organization/projects/%1$s/rate_limits/%2$s", project_id, rate_limit_id],
                body: parsed,
                model: OpenAI::Admin::Organization::Projects::ProjectRateLimit,
                security: {admin_api_key_auth: true},
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
end
