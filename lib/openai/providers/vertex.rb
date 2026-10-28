# frozen_string_literal: true

require "timeout"

module OpenAI
  module Providers
    # @api private
    module Vertex
      SCOPE = "https://www.googleapis.com/auth/cloud-platform"
      AUTH_MARKER = :openai_vertex_bearer

      class Definition
        def initialize(base_url:, token_provider:, credentials:)
          @base_url = base_url.freeze
          @token_provider = token_provider
          @credentials = credentials
          @credentials_mutex = Mutex.new
        end

        def name = "vertex"

        def configure
          token_provider = @token_provider
          credentials = @credentials
          unless token_provider || credentials
            begin
              require "googleauth"

            rescue LoadError => e
              raise LoadError.new("Vertex ADC requires optional gem \"googleauth\"; add it to your Gemfile."), cause: e
            end

            begin
              credentials = Google::Auth.get_application_default(SCOPE)
            rescue StandardError => e
              raise OpenAI::Errors::Error.new("Vertex could not load Google Application Default Credentials."), cause: e
            end
          end

          if credentials
            # googleauth apply! refreshes expired tokens. Serialize just this
            # cache/refresh step across all clients using this provider.
            mutex = @credentials_mutex
            rejected_token = nil
            token_provider = lambda do
              headers = {}
              mutex.synchronize do
                credentials.apply!(headers)
                token = headers.fetch(:authorization) { headers.fetch("authorization") }.delete_prefix("Bearer ")
                if token == rejected_token && credentials.respond_to?(:fetch_access_token!)
                  credentials.fetch_access_token!
                  credentials.apply!(headers)
                  token = headers.fetch(:authorization) { headers.fetch("authorization") }.delete_prefix("Bearer ")
                  rejected_token = nil
                end

                token
              end
            end
          end

          # Share the replay allowance and retry count, but reset the deadline
          # for each ordinary transport retry. A 401 replay keeps its deadline.
          # Refresh itself happens in prepare_request, under its timeout and mutex.
          if credentials.respond_to?(:fetch_access_token!)
            wrapper = lambda do |request, replayable, retry_count, &send_request|
              context = request[:vertex_auth_context] || {replayed: false}
              context[:retry_count] = retry_count
              context[:deadline] = request[:timeout]&.then { OpenAI::Internal::Util.monotonic_secs + _1 }
              request = request.merge(vertex_auth_context: context)
              begin
                send_request.call(request, context[:retry_count])
              rescue OpenAI::Errors::AuthenticationError
                remaining = context[:deadline] && (context[:deadline] - OpenAI::Internal::Util.monotonic_secs)
                if remaining && remaining <= 0
                  raise OpenAI::Errors::APITimeoutError.new(url: request.fetch(:url))
                end

                begin
                  Timeout.timeout(remaining) { mutex.synchronize { rejected_token = context[:token] } }
                rescue Timeout::Error
                  raise OpenAI::Errors::APITimeoutError.new(url: request.fetch(:url)), cause: nil
                end

                raise if context[:replayed] || !replayable || context[:retry_count] >= request.fetch(:max_retries)

                context[:replayed] = true
                context[:retry_count] += 1
                retry
              end
            end
          end

          base = URI(@base_url)
          OpenAI::Internal::Provider::Runtime.new(
            name: name,
            base_url: @base_url,
            authentication_headers: %w[authorization],
            wrap_request: wrapper,
            prepare_request: lambda do |request|
              url = request.fetch(:url)
              unless OpenAI::Internal::Util.uri_origin(url) == OpenAI::Internal::Util.uri_origin(base)
                raise OpenAI::Errors::Error, "Vertex refuses credentials for an origin other than the configured URL."
              end

              headers = request.fetch(:headers).dup
              if request[:provider_auth] == AUTH_MARKER
                headers.delete("authorization")
              elsif headers.key?("authorization")
                raise(
                  OpenAI::Errors::Error,
                  "Vertex authentication cannot be combined with a custom Authorization header."
                )
              end

              if headers.key?("api-key")
                raise OpenAI::Errors::Error, "Vertex authentication cannot be combined with a custom api-key header."
              end

              headers.delete("openai-organization")
              headers.delete("openai-project")
              timeout = request[:timeout]
              context = request[:vertex_auth_context]
              timeout = context[:deadline] - OpenAI::Internal::Util.monotonic_secs if context&.dig(:deadline)
              if timeout && timeout <= 0
                raise OpenAI::Errors::APITimeoutError.new(url: url, message: "Vertex credential lookup timed out")
              end

              started = OpenAI::Internal::Util.monotonic_secs
              token = begin
                Timeout.timeout(timeout) { token_provider.call }
              rescue Timeout::Error => e
                raise(
                  OpenAI::Errors::APITimeoutError.new(url: url, message: "Vertex credential lookup timed out"),
                  cause: e
                )
              rescue StandardError => e
                raise OpenAI::Errors::Error.new("Vertex failed to resolve Google credentials."), cause: e
              end

              remaining = timeout && (timeout - (OpenAI::Internal::Util.monotonic_secs - started))
              if remaining && remaining <= 0
                raise OpenAI::Errors::APITimeoutError.new(url: url, message: "Vertex credential lookup timed out")
              end

              if credentials.respond_to?(:quota_project_id) && (quota = credentials.quota_project_id)
                headers["x-goog-user-project"] = quota
              end

              unless token.is_a?(String) && !token.strip.empty?
                raise OpenAI::Errors::Error, "Vertex token_provider must return a non-empty access token string."
              end

              context[:token] = token if context

              request.merge(
                timeout: remaining,
                headers: headers.merge("authorization" => "Bearer #{token}"),
                provider_auth: AUTH_MARKER,
                follow_redirects: false
              )
            end
          )
        end
      end
    end

    class << self
      # Use Google Application Default Credentials with the regular Responses
      # client. Supply token_provider: -> { ... } for application-managed credentials.
      # It is called per attempt and should cache/refresh tokens as needed.
      #
      # Base URL is the complete trusted provider URL before /responses. When
      # omitted, project and location are required. OpenAI environment defaults
      # and top-level auth/base_url options are ignored/rejected by Client.
      def vertex(project: nil, location: nil, base_url: nil, token_provider: nil, credentials: nil)
        if credentials && token_provider
          raise ArgumentError, "Vertex credentials and token_provider are mutually exclusive."
        end

        if credentials && !credentials.respond_to?(:apply!)
          raise ArgumentError, "Vertex credentials must provide Google's apply! method."
        end

        unless token_provider.nil? || token_provider.respond_to?(:call)
          raise ArgumentError, "Vertex token_provider must respond to call."
        end

        if base_url.nil?
          project_segment = /\A[a-zA-Z0-9][a-zA-Z0-9_.:-]*\z/
          location_segment = /\A[a-zA-Z0-9][a-zA-Z0-9_-]*\z/
          unless project.is_a?(String) &&
              location.is_a?(String) &&
              project_segment.match?(project) &&
              location_segment.match?(location)
            raise ArgumentError, "Vertex project and location are required and must be single path segments."
          end

          host = location == "global" ? "aiplatform.googleapis.com" : "#{location}-aiplatform.googleapis.com"
          base_url = "https://#{host}/v1/projects/#{project}/locations/#{location}/publishers/openai/v1"
        end

        begin
          uri = URI(base_url.to_s)
          unless %w[http https].include?(uri.scheme) && uri.host && !uri.userinfo && !uri.query && !uri.fragment
            raise URI::InvalidURIError
          end

        rescue URI::InvalidURIError
          raise ArgumentError, "Vertex base_url must be an absolute HTTP(S) URL without credentials, query or fragment."
        end

        OpenAI::Internal::Provider.create(
          Vertex::Definition.new(base_url: uri.to_s, token_provider: token_provider, credentials: credentials)
        )
      end
    end
  end
end
