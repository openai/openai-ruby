# typed: strong

module OpenAI
  module Resources
    class Admin
      class Organization
        class Projects
          class RateLimits
            # Returns the rate limits per model for a project.
            sig do
              params(
                project_id: String,
                after: String,
                before: String,
                limit: Integer,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(
                OpenAI::Internal::ConversationCursorPage[
                  OpenAI::Admin::Organization::Projects::ProjectRateLimit
                ]
              )
            end
            def list_rate_limits(
              # The ID of the project.
              project_id,
              # A cursor for use in pagination. `after` is an object ID that defines your place
              # in the list. For instance, if you make a list request and receive 100 objects,
              # ending with obj_foo, your subsequent call can include after=obj_foo in order to
              # fetch the next page of the list.
              after: nil,
              # A cursor for use in pagination. `before` is an object ID that defines your place
              # in the list. For instance, if you make a list request and receive 100 objects,
              # beginning with obj_foo, your subsequent call can include before=obj_foo in order
              # to fetch the previous page of the list.
              before: nil,
              # A limit on the number of objects to be returned. The default is 100.
              limit: nil,
              request_options: {}
            )
            end

            # Updates a project rate limit.
            sig do
              params(
                rate_limit_id: String,
                project_id: String,
                batch_1_day_max_input_tokens: Integer,
                max_audio_megabytes_per_1_minute: Integer,
                max_images_per_1_minute: Integer,
                max_requests_per_1_day: Integer,
                max_requests_per_1_minute: Integer,
                max_tokens_per_1_minute: Integer,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(OpenAI::Admin::Organization::Projects::ProjectRateLimit)
            end
            def update_rate_limit(
              # Path param: The ID of the rate limit.
              rate_limit_id,
              # Path param: The ID of the project.
              project_id:,
              # Body param: The maximum batch input tokens per day. Only relevant for certain
              # models.
              batch_1_day_max_input_tokens: nil,
              # Body param: The maximum audio megabytes per minute. Only relevant for certain
              # models.
              max_audio_megabytes_per_1_minute: nil,
              # Body param: The maximum images per minute. Only relevant for certain models.
              max_images_per_1_minute: nil,
              # Body param: The maximum requests per day. Only relevant for certain models.
              max_requests_per_1_day: nil,
              # Body param: The maximum requests per minute.
              max_requests_per_1_minute: nil,
              # Body param: The maximum tokens per minute.
              max_tokens_per_1_minute: nil,
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
end
