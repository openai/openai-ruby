# typed: strong
module OpenAI
  module Helpers
    module Beta
      module Agents
        class PreparedFiles
          sig { returns(T::Array[OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID]) }
          attr_reader :files
          sig { returns(T::Array[String]) }
          attr_reader :upload_ids
          sig { params(files: T::Array[T::Hash[Symbol, T.untyped]]).void }
          def initialize(files)
          end
        end

        class FilePreparationError < OpenAI::Errors::Error
          sig { returns(PreparedFiles) }
          attr_reader :prepared
          sig { params(prepared: PreparedFiles).returns(T.attached_class) }
          def self.new(prepared:)
          end
        end
        # @api private
        class FilePreparation
          sig {
            params(client: OpenAI::Client, environment_files: OpenAI::Resources::Beta::Agents::Environments::Files).void
          }
          def initialize(client:, environment_files:)
          end

          sig {
            params(files: T::Hash[String, T.any(String, Pathname)], request_options: OpenAI::RequestOptions::OrHash)
              .returns(PreparedFiles)
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
              .returns(PreparedFiles)
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
              .returns(PreparedFiles)
          }
          def upload(environment_id, file:, path:, request_options: {})
          end
        end
      end
    end
  end
end
