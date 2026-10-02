# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Environments

          class Files
            # Beta file helpers.
            sig {
              params(files: T::Hash[String, T.any(String, Pathname)], request_options: OpenAI::RequestOptions::OrHash)
                .returns(OpenAI::Helpers::Beta::Agents::PreparedFiles)
            }
            def prepare(files, request_options: {})
            end

            sig {
              params(
                directory: T.any(String, Pathname),
                destination: String,
                include: T::Array[String],
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Helpers::Beta::Agents::PreparedFiles)
            }
            def prepare_directory(directory, destination:, include:, request_options: {})
            end

            sig {
              params(
                environment_id: String,
                file: T.any(String, Pathname),
                path: String,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Helpers::Beta::Agents::PreparedFiles)
            }
            def upload(environment_id, file:, path:, request_options: {})
            end

            # Copies inline bytes or a Files API file into a connected execution environment.
            # See
            # [environment files](https://developers.openai.com/api/docs/guides/agents-api/environments/files).
            sig {
              params(
                environment_id: String,
                hosted_environment_file_param: T.any(
                  OpenAI::Beta::HostedEnvironmentFileParam::FileID::OrHash,
                  OpenAI::Beta::HostedEnvironmentFileParam::Inline::OrHash
                ),
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Beta::Agents::Environments::EnvironmentFile)
            }
            def create(
              # The ID of the environment.
              environment_id,
              # A file materialized in an OpenAI-hosted execution environment.
              hosted_environment_file_param:,
              request_options: {}
            )
            end

            # Lists live files on a connected execution environment with optional directory
            # filtering and opaque cursor pagination. See
            # [environment files](https://developers.openai.com/api/docs/guides/agents-api/environments/files).
            sig {
              params(
                environment_id: String,
                limit: T.nilable(Integer),
                order: OpenAI::Beta::Agents::Environments::FileListParams::Order::OrSymbol,
                page: String,
                path: T.nilable(String),
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Internal::TokenPage[OpenAI::Beta::Agents::Environments::EnvironmentFile])
            }
            def list(
              # The ID of the environment.
              environment_id,
              # The maximum number of files to return, between 1 and 100.
              limit: nil,
              # Sort by case-sensitive path components. Defaults to descending.
              order: nil,
              # The opaque token from the previous page. Keep the same path, order, and limit.
              page: nil,
              # Restrict the listing to this absolute workspace directory.
              path: nil,
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
