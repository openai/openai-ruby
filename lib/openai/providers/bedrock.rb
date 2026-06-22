# frozen_string_literal: true

module OpenAI
  module Providers
    # @api private
    module Bedrock
      SERVICE = "bedrock-mantle"
      CANONICAL_HOST = /\Abedrock-mantle\.([a-z0-9-]+)\.api\.aws\z/i
      SIGNING_HEADERS = %w[authorization x-amz-content-sha256 x-amz-date x-amz-security-token].freeze
      BEARER_AUTH_MARKER = :openai_bedrock_bearer
      SIGV4_AUTH_MARKER = :openai_bedrock_sigv4
      MISSING_REGION_MESSAGE =
        "Bedrock requires an AWS region. Pass `region` to `bedrock(...)`, or set `AWS_REGION` " \
        "or `AWS_DEFAULT_REGION`."
      MISSING_CREDENTIALS_MESSAGE =
        "Could not find credentials for Bedrock. Pass a bearer credential or AWS credentials " \
        "to `bedrock(...)`, set `AWS_BEARER_TOKEN_BEDROCK`, or configure the default AWS credential chain."
      CREDENTIAL_RESOLUTION_MESSAGE =
        "Failed to resolve AWS credentials for Bedrock. Verify your AWS profile, environment " \
        "variables, or runtime identity configuration and try again."
      NON_REPLAYABLE_BODY_MESSAGE =
        "Bedrock SigV4 authentication requires a replayable request body. Buffer the body " \
        "before sending or use bearer authentication."
      MISSING_DEPENDENCY_MESSAGE =
        "Bedrock AWS authentication requires optional AWS dependencies. Add `gem \"aws-sdk-core\"` " \
        "to your Gemfile, run `bundle install`, and try again."
      PARTIAL_STATIC_CREDENTIALS_MESSAGE =
        "Static AWS credentials require both `access_key_id` and `secret_access_key`. " \
        "A `session_token` may only be used with both."
      AMBIGUOUS_AWS_AUTH_MESSAGE =
        "Bedrock authentication is ambiguous. Configure exactly one explicit AWS mode: " \
        "static credentials, profile, or credential provider."
      AMBIGUOUS_AUTH_MESSAGE =
        "Bedrock authentication is ambiguous. Configure exactly one explicit mode: bearer " \
        "credential, static AWS credentials, profile, or credential provider."

      class Definition
        attr_reader :name

        def initialize(
          region:,
          base_url:,
          bearer_provider:,
          profile:,
          access_key_id:,
          secret_access_key:,
          session_token:,
          credentials_provider:,
          default_chain:
        )
          @name = "bedrock"
          @region = region&.freeze
          @base_url = base_url&.freeze
          @bearer_provider = bearer_provider
          @profile = profile&.freeze
          @access_key_id = access_key_id&.freeze
          @secret_access_key = secret_access_key&.freeze
          @session_token = session_token&.freeze
          @credentials_provider = credentials_provider
          @default_chain = default_chain
        end

        def configure
          if @bearer_provider
            base_url = Bedrock.resolve_base_url(@base_url, @region)
            auth = BearerAuth.new(token_provider: @bearer_provider, base_url: base_url)
          else
            Bedrock.load_aws!
            region = @region || Bedrock.profile_region(@profile)
            raise OpenAI::Errors::Error, MISSING_REGION_MESSAGE if region.nil?

            base_url = Bedrock.resolve_base_url(@base_url, region)
            credentials =
              if @access_key_id
                Aws::Credentials.new(@access_key_id, @secret_access_key, @session_token)
              elsif @credentials_provider
                CustomCredentialsProvider.new(@credentials_provider)
              elsif @profile
                ProfileCredentialsProvider.new(@profile, region: region)
              else
                DefaultCredentialsProvider.new
              end
            auth = SigV4Auth.new(
              region: region,
              base_url: base_url,
              credentials_provider: credentials,
              default_chain: @default_chain
            )
          end

          OpenAI::Internal::Provider::Runtime.new(
            name: name,
            base_url: base_url,
            prepare_request: auth.method(:prepare_request)
          )
        end
      end

      class BearerAuth
        def initialize(token_provider:, base_url:)
          @token_provider = token_provider
          @base_url = URI(base_url)
        end

        def prepare_request(request)
          Bedrock.validate_origin!(request.fetch(:url), @base_url, action: "authenticate")
          headers = Bedrock.provider_headers(request, marker: BEARER_AUTH_MARKER)
          token = @token_provider.call
          unless token.is_a?(String) && !token.strip.empty?
            raise OpenAI::Errors::Error,
                  "The Bedrock bearer credential provider must return a non-empty string."
          end

          request.merge(
            headers: headers.merge("authorization" => "Bearer #{token}"),
            provider_auth: BEARER_AUTH_MARKER
          )
        rescue OpenAI::Errors::Error
          raise
        rescue StandardError => e
          raise OpenAI::Errors::Error.new("Failed to resolve a bearer credential for Bedrock."), cause: e
        end
      end

      class SigV4Auth
        def initialize(region:, base_url:, credentials_provider:, default_chain:)
          @region = region
          @base_url = URI(base_url)
          @default_chain = default_chain
          @signer = Aws::Sigv4::Signer.new(
            service: SERVICE,
            region: region,
            credentials_provider: credentials_provider
          )
        end

        def prepare_request(request)
          url = request.fetch(:url)
          Bedrock.validate_origin!(url, @base_url, action: "sign")
          Bedrock.validate_endpoint_region!(url, @region)
          body = request[:body]
          unless body.nil? || body.is_a?(String)
            raise OpenAI::Errors::Error, NON_REPLAYABLE_BODY_MESSAGE
          end

          headers = Bedrock.provider_headers(request, marker: SIGV4_AUTH_MARKER)
          SIGNING_HEADERS.each { headers.delete(_1) }
          signature = @signer.sign_request(
            http_method: request.fetch(:method).to_s.upcase,
            url: url.to_s,
            headers: headers,
            body: body
          )

          request.merge(
            headers: OpenAI::Internal::Util.normalized_headers(headers, signature.headers),
            follow_redirects: false,
            provider_auth: SIGV4_AUTH_MARKER
          )
        rescue OpenAI::Errors::Error
          raise
        rescue StandardError => e
          message =
            if @default_chain
              MISSING_CREDENTIALS_MESSAGE
            else
              CREDENTIAL_RESOLUTION_MESSAGE
            end
          raise OpenAI::Errors::Error.new(message), cause: e
        end
      end

      class CustomCredentialsProvider
        def initialize(provider) = @provider = provider

        def credentials
          value = @provider.respond_to?(:call) ? @provider.call : @provider.credentials
          value = value.credentials if !value.respond_to?(:access_key_id) && value.respond_to?(:credentials)
          Bedrock.validate_credentials!(value)
        rescue OpenAI::Errors::Error
          raise
        rescue StandardError => e
          raise OpenAI::Errors::Error.new(CREDENTIAL_RESOLUTION_MESSAGE), cause: e
        end
      end

      class DefaultCredentialsProvider
        def initialize
          @mutex = Mutex.new
          @provider = nil
        end

        def credentials
          provider = @mutex.synchronize { @provider ||= Aws::CredentialProviderChain.new.resolve }
          raise OpenAI::Errors::Error, MISSING_CREDENTIALS_MESSAGE unless provider
          Bedrock.validate_credentials!(provider.credentials)
        end
      end

      class ProfileCredentialsProvider
        def initialize(profile, region:)
          @profile = profile
          @region = region
          @mutex = Mutex.new
          @provider = nil
        end

        def credentials
          provider = @mutex.synchronize { @provider ||= resolve }
          Bedrock.validate_credentials!(provider.credentials)
        rescue OpenAI::Errors::Error
          raise
        rescue StandardError => e
          raise OpenAI::Errors::Error.new(CREDENTIAL_RESOLUTION_MESSAGE), cause: e
        end

        private def resolve
          config = Aws.shared_config
          providers = []
          if config.config_enabled?
            providers << config.assume_role_web_identity_credentials_from_config(
              profile: @profile,
              region: @region
            )
            providers << config.sso_credentials_from_config(profile: @profile)
            providers << config.assume_role_credentials_from_config(profile: @profile, region: @region)
          end

          begin
            providers << Aws::SharedCredentials.new(profile_name: @profile)
          rescue Aws::Errors::NoSuchProfileError
            nil
          end

          if config.config_enabled?
            if config.respond_to?(:login_credentials_from_config)
              providers << config.login_credentials_from_config(profile: @profile, region: @region)
            end
            process = config.credential_process(profile: @profile)
            providers << Aws::ProcessCredentials.new([process]) if process
          end

          providers.compact.find(&:set?) || raise(OpenAI::Errors::Error, CREDENTIAL_RESOLUTION_MESSAGE)
        end
      end

      class << self
        def load_aws!
          require("aws-sdk-core")
          require("aws-sigv4")
        rescue LoadError => e
          raise OpenAI::Errors::Error.new(MISSING_DEPENDENCY_MESSAGE), cause: e
        end

        def resolve_base_url(base_url, region)
          return base_url if base_url
          raise OpenAI::Errors::Error, MISSING_REGION_MESSAGE if region.nil?
          "https://bedrock-mantle.#{region}.api.aws/v1"
        end

        def normalize_base_url(base_url)
          uri = URI(base_url)
          unless uri.is_a?(URI::HTTP) && uri.host
            raise OpenAI::Errors::Error, "The Bedrock `base_url` must be an absolute HTTP or HTTPS URL."
          end
          uri.path = uri.path.sub(%r{/responses(?:/.*)?\z}, "")
          uri.path = "" if uri.path == "/"
          uri.to_s.sub(%r{/\z}, "")
        rescue URI::InvalidURIError => e
          message = "The Bedrock `base_url` must be an absolute HTTP or HTTPS URL."
          raise OpenAI::Errors::Error.new(message), cause: e
        end

        def profile_region(profile)
          configured_profile = profile || ENV["AWS_PROFILE"] || ENV["AWS_DEFAULT_PROFILE"] || "default"
          region = Aws.shared_config.region(profile: configured_profile)
          normalize_optional_string(region)
        rescue StandardError => e
          raise OpenAI::Errors::Error.new(CREDENTIAL_RESOLUTION_MESSAGE), cause: e
        end

        def provider_headers(request, marker:)
          headers = request.fetch(:headers).dup
          if request[:provider_auth] == marker
            headers.delete("authorization")
          elsif headers.key?("authorization")
            raise OpenAI::Errors::Error,
                  "Bedrock provider authentication cannot be combined with a custom `Authorization` header."
          end
          headers
        end

        def validate_origin!(url, base_url, action:)
          return if OpenAI::Internal::Util.uri_origin(url) == OpenAI::Internal::Util.uri_origin(base_url)
          message =
            "Refusing to #{action} a Bedrock request for an origin other than the configured " \
            "provider URL."
          raise OpenAI::Errors::Error,
                message
        end

        def validate_endpoint_region!(url, region)
          endpoint_region = CANONICAL_HOST.match(url.host)&.[](1)
          return if endpoint_region.nil? || endpoint_region == region
          message =
            "The Bedrock endpoint region `#{endpoint_region}` does not match the SigV4 " \
            "region `#{region}`."
          raise OpenAI::Errors::Error,
                message
        end

        def validate_credentials!(credentials)
          access_key_id = credentials&.access_key_id
          secret_access_key = credentials&.secret_access_key
          session_token = credentials&.session_token if credentials.respond_to?(:session_token)
          valid =
            access_key_id.is_a?(String) && !access_key_id.strip.empty? &&
            secret_access_key.is_a?(String) && !secret_access_key.strip.empty? &&
            (session_token.nil? || (session_token.is_a?(String) && !session_token.strip.empty?))
          return credentials if valid
          raise OpenAI::Errors::Error, CREDENTIAL_RESOLUTION_MESSAGE
        end

        def normalize_optional_string(value)
          return nil if value.nil?
          return nil unless value.is_a?(String)
          normalized = value.strip
          normalized unless normalized.empty?
        end
      end
    end

    class << self
      # Configure the standard OpenAI client for Amazon Bedrock Mantle.
      #
      # Authentication precedence is an explicit bearer or AWS mode, then
      # AWS_BEARER_TOKEN_BEDROCK, then the standard AWS credential chain.
      #
      # @param region [String, nil] AWS signing region. Defaults to `AWS_REGION`,
      #   `AWS_DEFAULT_REGION`, or the selected profile's configured region.
      #
      # @param base_url [String, nil] Bedrock API root. Defaults to
      #   `AWS_BEDROCK_BASE_URL` or the regional Bedrock Mantle endpoint.
      #
      # @param api_key [String, nil] Explicit Bedrock bearer credential. Passing
      #   `nil` explicitly skips the `AWS_BEARER_TOKEN_BEDROCK` fallback.
      #
      # @param token_provider [#call, nil] Callable returning a fresh bearer
      #   credential before each request attempt.
      #
      # @param access_key_id [String, nil] Explicit AWS access key ID. Must be
      #   paired with `secret_access_key`.
      #
      # @param secret_access_key [String, nil] Explicit AWS secret access key.
      #
      # @param session_token [String, nil] Optional session token for explicit
      #   temporary AWS credentials.
      #
      # @param profile [String, nil] Explicit AWS shared-config profile.
      #
      # @param credentials_provider [#credentials, #call, nil] Refreshable AWS
      #   credentials provider. A callable must return an AWS credential identity.
      #
      # @return [OpenAI::Internal::Provider::Handle]
      def bedrock(
        region: nil,
        base_url: OpenAI::Internal::OMIT,
        api_key: OpenAI::Internal::OMIT,
        token_provider: nil,
        access_key_id: nil,
        secret_access_key: nil,
        session_token: nil,
        profile: nil,
        credentials_provider: nil
      )
        normalized_region = Bedrock.normalize_optional_string(region)
        if !region.nil? && normalized_region.nil?
          raise OpenAI::Errors::Error, "The Bedrock AWS `region` must not be empty."
        end
        normalized_region ||= Bedrock.normalize_optional_string(ENV["AWS_REGION"]) ||
                              Bedrock.normalize_optional_string(ENV["AWS_DEFAULT_REGION"])

        normalized_profile = Bedrock.normalize_optional_string(profile)
        if !profile.nil? && normalized_profile.nil?
          raise OpenAI::Errors::Error, "The Bedrock AWS `profile` must not be empty."
        end

        configured_base_url =
          if base_url.equal?(OpenAI::Internal::OMIT)
            Bedrock.normalize_optional_string(ENV["AWS_BEDROCK_BASE_URL"])
          elsif base_url.nil?
            nil
          else
            normalized = Bedrock.normalize_optional_string(base_url)
            raise(OpenAI::Errors::Error, "The Bedrock `base_url` must not be empty.") unless normalized
            normalized
          end
        configured_base_url = Bedrock.normalize_base_url(configured_base_url) if configured_base_url

        has_access_key = !access_key_id.nil?
        has_secret_key = !secret_access_key.nil?
        if has_access_key != has_secret_key || (!session_token.nil? && !has_access_key)
          raise OpenAI::Errors::Error, Bedrock::PARTIAL_STATIC_CREDENTIALS_MESSAGE
        end
        normalized_access_key_id = Bedrock.normalize_optional_string(access_key_id)
        normalized_secret_access_key = Bedrock.normalize_optional_string(secret_access_key)
        normalized_session_token = Bedrock.normalize_optional_string(session_token)
        if has_access_key && [normalized_access_key_id, normalized_secret_access_key].any?(&:nil?)
          raise OpenAI::Errors::Error,
                "Static AWS credentials require non-empty `access_key_id` and `secret_access_key` values."
        end
        if !session_token.nil? && normalized_session_token.nil?
          raise OpenAI::Errors::Error, "A static AWS `session_token` must not be empty when provided."
        end

        explicit_api_key = !api_key.equal?(OpenAI::Internal::OMIT) && !api_key.nil?
        normalized_api_key = Bedrock.normalize_optional_string(api_key)
        if explicit_api_key && normalized_api_key.nil?
          raise OpenAI::Errors::Error, "The Bedrock bearer credential must not be empty."
        end
        if explicit_api_key && token_provider
          raise OpenAI::Errors::Error,
                "The `api_key` and `token_provider` options are mutually exclusive. Configure only one."
        end
        if token_provider && !token_provider.respond_to?(:call)
          raise OpenAI::Errors::Error, "The Bedrock `token_provider` must respond to `call`."
        end
        if credentials_provider &&
           !credentials_provider.respond_to?(:call) &&
           !credentials_provider.respond_to?(:credentials)
          raise OpenAI::Errors::Error,
                "The Bedrock `credentials_provider` must respond to `call` or `credentials`."
        end

        explicit_bearer = explicit_api_key || !token_provider.nil?
        aws_modes = [has_access_key, !normalized_profile.nil?, !credentials_provider.nil?].count(true)
        if aws_modes > 1
          raise OpenAI::Errors::Error, Bedrock::AMBIGUOUS_AWS_AUTH_MESSAGE
        end
        if explicit_bearer && aws_modes.positive?
          raise OpenAI::Errors::Error, Bedrock::AMBIGUOUS_AUTH_MESSAGE
        end

        skip_environment_bearer = !api_key.equal?(OpenAI::Internal::OMIT) && api_key.nil?
        environment_bearer =
          !explicit_bearer && aws_modes.zero? && !skip_environment_bearer &&
          !Bedrock.normalize_optional_string(ENV["AWS_BEARER_TOKEN_BEDROCK"]).nil?
        bearer_provider =
          if explicit_api_key
            normalized_api_key.freeze
            -> { normalized_api_key }
          elsif token_provider
            token_provider
          elsif environment_bearer
            lambda do
              ENV["AWS_BEARER_TOKEN_BEDROCK"] ||
                raise(OpenAI::Errors::Error, Bedrock::MISSING_CREDENTIALS_MESSAGE)
            end
          end

        if bearer_provider && configured_base_url.nil? && normalized_region.nil?
          raise OpenAI::Errors::Error, Bedrock::MISSING_REGION_MESSAGE
        end

        definition = Bedrock::Definition.new(
          region: normalized_region,
          base_url: configured_base_url,
          bearer_provider: bearer_provider,
          profile: normalized_profile,
          access_key_id: normalized_access_key_id,
          secret_access_key: normalized_secret_access_key,
          session_token: normalized_session_token,
          credentials_provider: credentials_provider,
          default_chain: aws_modes.zero?
        )
        OpenAI::Internal::Provider.create(definition)
      end
    end
  end
end
