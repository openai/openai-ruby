# frozen_string_literal: true

module OpenAI
  module Providers
    # @api private
    module Azure
      API_KEY_AUTH_MARKER = :openai_azure_api_key
      BEARER_AUTH_MARKER = :openai_azure_bearer
      AUTH_HEADERS = %w[api-key authorization].freeze
      MISSING_ENDPOINT_MESSAGE = "Azure OpenAI requires an endpoint. Pass `endpoint` to `azure(...)`, or set " \
        "`AZURE_OPENAI_ENDPOINT`."
      MISSING_CREDENTIALS_MESSAGE = "Could not find credentials for Azure OpenAI. Pass `api_key` or `token_provider` " \
        "to `azure(...)`, or set `AZURE_OPENAI_API_KEY`."

      class Definition
        attr_reader :name

        def initialize(base_url:, credential_provider:, authentication:)
          @name = "azure"
          @base_url = base_url.freeze
          @credential_provider = credential_provider
          @authentication = authentication
        end

        def configure
          auth = Auth.new(
            base_url: @base_url,
            credential_provider: @credential_provider,
            authentication: @authentication
          )
          OpenAI::Internal::Provider::Runtime.new(
            name: name,
            base_url: @base_url,
            prepare_request: auth.method(:prepare_request),
            authentication_headers: AUTH_HEADERS
          )
        end
      end

      class Auth
        def initialize(base_url:, credential_provider:, authentication:)
          @base_url = URI(base_url)
          @credential_provider = credential_provider
          @authentication = authentication
        end

        def prepare_request(request)
          Azure.validate_origin!(request.fetch(:url), @base_url)
          marker = @authentication == :api_key ? API_KEY_AUTH_MARKER : BEARER_AUTH_MARKER
          headers = Azure.provider_headers(request, marker: marker)
          credential = resolve_credential
          auth_header = if @authentication == :api_key
            {"api-key" => credential}
          else
            {"authorization" => "Bearer #{credential}"}
          end

          request.merge(headers: headers.merge(auth_header), provider_auth: marker)
        end

        private def resolve_credential
          credential = @credential_provider.call
          unless credential.is_a?(String) && !credential.strip.empty?
            name = @authentication == :api_key ? "API key" : "token provider"
            raise(
              OpenAI::Errors::Error,
              "The Azure OpenAI #{name} must return a non-empty string."
            )
          end

          credential
        rescue OpenAI::Errors::Error
          raise
        rescue StandardError => e
          message = if @authentication == :api_key
            "Failed to resolve an API key for Azure OpenAI."
          else
            "Failed to resolve a bearer token for Azure OpenAI."
          end

          raise OpenAI::Errors::Error.new(message), cause: e
        end
      end

      class << self
        def normalize_endpoint(endpoint)
          uri = URI(endpoint)
          unless uri.is_a?(URI::HTTP) && uri.host
            raise ArgumentError, "The Azure OpenAI `endpoint` must be an absolute HTTP or HTTPS URL."
          end

          unless uri.query.nil?
            raise ArgumentError, "The Azure OpenAI `endpoint` must not include a query string."
          end

          unless uri.fragment.nil?
            raise ArgumentError, "The Azure OpenAI `endpoint` must not include a fragment."
          end

          unless uri.userinfo.nil?
            raise ArgumentError, "The Azure OpenAI `endpoint` must not include user information."
          end

          path = uri.path.sub(%r{/+\z}, "")
          uri.path = case path
          when %r{/openai/v1\z}
            path
          when %r{/openai\z}
            "#{path}/v1"
          else
            "#{path}/openai/v1"
          end

          uri.to_s
        rescue URI::InvalidURIError => e
          message = "The Azure OpenAI `endpoint` must be an absolute HTTP or HTTPS URL."
          raise ArgumentError.new(message), cause: e
        end

        def normalize_optional_string(value)
          return nil unless value.is_a?(String)
          normalized = value.strip
          normalized unless normalized.empty?
        end

        def provider_headers(request, marker:)
          headers = request.fetch(:headers).dup
          if request[:provider_auth] == marker
            AUTH_HEADERS.each { headers.delete(_1) }
          elsif AUTH_HEADERS.any? { headers.key?(_1) }
            raise(
              OpenAI::Errors::Error,
              "Azure OpenAI provider authentication cannot be combined with a custom " \
                "`Authorization` or `api-key` header."
            )
          end

          headers
        end

        def validate_origin!(url, base_url)
          return if OpenAI::Internal::Util.uri_origin(url) == OpenAI::Internal::Util.uri_origin(base_url)
          raise(
            OpenAI::Errors::Error,
            "Refusing to authenticate a request for an origin other than the configured " \
              "Azure OpenAI endpoint."
          )
        end
      end
    end

    class << self
      # Configure the standard OpenAI client for the Azure OpenAI v1 API.
      #
      # @param endpoint [String, nil] Azure OpenAI resource endpoint. Defaults to
      #   `AZURE_OPENAI_ENDPOINT`. `/openai/v1` is appended when absent.
      #
      # @param api_key [String, nil] Azure OpenAI API key. Defaults to
      #   `AZURE_OPENAI_API_KEY` when no token provider is configured. Passing
      #   `nil` explicitly skips the environment fallback.
      #
      # @param token_provider [#call, nil] Callable returning a Microsoft Entra
      #   bearer token before each request attempt.
      #
      # @return [OpenAI::Provider]
      def azure(
        endpoint: OpenAI::Internal::OMIT,
        api_key: OpenAI::Internal::OMIT,
        token_provider: nil
      )
        configured_endpoint = if endpoint.equal?(OpenAI::Internal::OMIT)
          Azure.normalize_optional_string(ENV["AZURE_OPENAI_ENDPOINT"])
        else
          normalized = Azure.normalize_optional_string(endpoint)
          if !endpoint.nil? && normalized.nil?
            raise ArgumentError, "The Azure OpenAI `endpoint` must not be empty."
          end

          normalized
        end

        raise ArgumentError, Azure::MISSING_ENDPOINT_MESSAGE if configured_endpoint.nil?
        base_url = Azure.normalize_endpoint(configured_endpoint)

        explicit_api_key = !api_key.equal?(OpenAI::Internal::OMIT) && !api_key.nil?
        normalized_api_key = Azure.normalize_optional_string(api_key)
        if explicit_api_key && normalized_api_key.nil?
          raise ArgumentError, "The Azure OpenAI API key must not be empty."
        end

        unless token_provider.nil? || token_provider.respond_to?(:call)
          raise ArgumentError, "The Azure OpenAI `token_provider` must respond to `call`."
        end

        if explicit_api_key && !token_provider.nil?
          raise(
            ArgumentError,
            "The Azure OpenAI `api_key` and `token_provider` options are mutually exclusive."
          )
        end

        environment_api_key = if api_key.equal?(OpenAI::Internal::OMIT) && token_provider.nil?
          Azure.normalize_optional_string(ENV["AZURE_OPENAI_API_KEY"])
        end

        resolved_api_key = normalized_api_key || environment_api_key
        if resolved_api_key.nil? && token_provider.nil?
          raise ArgumentError, Azure::MISSING_CREDENTIALS_MESSAGE
        end

        if token_provider
          credential_provider = token_provider
          authentication = :bearer
        else
          resolved_api_key.freeze
          credential_provider = -> { resolved_api_key }
          authentication = :api_key
        end

        definition = Azure::Definition.new(
          base_url: base_url,
          credential_provider: credential_provider,
          authentication: authentication
        )
        OpenAI::Internal::Provider.create(definition)
      end
    end
  end
end
