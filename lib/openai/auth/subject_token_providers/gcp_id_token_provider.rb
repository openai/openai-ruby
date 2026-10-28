# frozen_string_literal: true

module OpenAI
  module Auth
    module SubjectTokenProviders
      class GCPIDTokenProvider
        include OpenAI::Auth::SubjectTokenProvider

        METADATA_HOST = "metadata.google.internal"
        DEFAULT_AUDIENCE = "https://api.openai.com/v1"
        DEFAULT_TIMEOUT = 10.0

        def initialize(
          audience: self.class::DEFAULT_AUDIENCE,
          timeout: self.class::DEFAULT_TIMEOUT
        )
          @audience = audience
          @timeout = timeout
        end

        def token_type
          TokenType::ID
        end

        def get_token
          path = "/computeMetadata/v1/instance/service-accounts/default/identity"
          uri = URI::HTTP.build(
            host: self.class::METADATA_HOST,
            path: path,
            query: URI.encode_www_form("audience" => @audience)
          )

          request = Net::HTTP::Get.new(uri)
          request["Metadata-Flavor"] = "Google"

          response = Net::HTTP
            .start(
              uri.hostname,
              uri.port,
              use_ssl: false,
              open_timeout: @timeout,
              read_timeout: @timeout
            ) do |http|
              http.request(request)
            end

          unless response.is_a?(Net::HTTPSuccess)
            raise(
              OpenAI::Errors::SubjectTokenProviderError.new(
                message: "GCP Metadata Server returned #{response.code}",
                provider: "gcp-metadata"
              ),
              cause: nil
            )
          end

          response.body
        rescue OpenAI::Errors::SubjectTokenProviderError
          raise
        rescue StandardError
          raise(
            OpenAI::Errors::SubjectTokenProviderError.new(
              message: "Failed to fetch token from GCP Metadata Server",
              provider: "gcp-metadata"
            ),
            cause: nil
          )
        end
      end
    end
  end
end
