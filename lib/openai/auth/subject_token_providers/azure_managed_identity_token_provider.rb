# frozen_string_literal: true

module OpenAI
  module Auth
    module SubjectTokenProviders
      class AzureManagedIdentityTokenProvider
        include OpenAI::Auth::SubjectTokenProvider

        IMDS_ENDPOINT = "http://169.254.169.254/metadata/identity/oauth2/token"
        DEFAULT_RESOURCE = "https://management.azure.com/"
        DEFAULT_API_VERSION = "2018-02-01"
        DEFAULT_TIMEOUT = 10.0

        def initialize(
          resource: self.class::DEFAULT_RESOURCE,
          object_id: nil,
          client_id: nil,
          msi_res_id: nil,
          api_version: self.class::DEFAULT_API_VERSION,
          timeout: self.class::DEFAULT_TIMEOUT
        )
          @resource = resource
          @object_id = object_id
          @client_id = client_id
          @msi_res_id = msi_res_id
          @api_version = api_version
          @timeout = timeout
        end

        def token_type
          TokenType::JWT
        end

        def get_token
          uri = URI(self.class::IMDS_ENDPOINT)
          params = {
            "api-version" => @api_version,
            "resource" => @resource
          }
          params["object_id"] = @object_id if @object_id
          params["client_id"] = @client_id if @client_id
          params["msi_res_id"] = @msi_res_id if @msi_res_id
          uri.query = URI.encode_www_form(params)

          request = Net::HTTP::Get.new(uri)
          request["Metadata"] = "true"

          response = Net::HTTP.start(
            uri.hostname,
            uri.port,
            use_ssl: uri.scheme == "https",
            open_timeout: @timeout,
            read_timeout: @timeout
          ) do |http|
            http.request(request)
          end

          unless response.is_a?(Net::HTTPSuccess)
            raise OpenAI::Errors::SubjectTokenProviderError.new(
              message: "Azure IMDS returned #{response.code}: #{response.body}",
              provider: "azure-imds"
            )
          end

          data = JSON.parse(response.body, symbolize_names: true)

          case data
          in {access_token: String => token}
            token
          else
            raise OpenAI::Errors::SubjectTokenProviderError.new(
              message: "Azure IMDS response missing access_token field",
              provider: "azure-imds"
            )
          end
        rescue OpenAI::Errors::SubjectTokenProviderError
          raise
        rescue StandardError => e
          raise OpenAI::Errors::SubjectTokenProviderError.new(
            message: "Failed to fetch token from Azure IMDS: #{e.message}",
            provider: "azure-imds",
            cause: e
          )
        end
      end
    end
  end
end
