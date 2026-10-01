# frozen_string_literal: true

require "tmpdir"

module OpenAI
  module Helpers
    module Beta
      module Agents
        # Uploaded file references ready for a hosted environment (beta).
        # Delete upload_ids explicitly through the Files API when no longer needed.
        class PreparedFiles
          attr_reader :files, :upload_ids

          # @api private
          def initialize(files)
            @files = files
              .map do |file|
                OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID
                  .new(
                    file_id: file.fetch(:file_id).dup.freeze,
                    path: file.fetch(:path).dup.freeze
                  )
                  .freeze
              end
              .freeze
            @upload_ids = @files.map(&:file_id).freeze
          end
        end

        # A preparation failed after uploads may have been created (beta).
        class FilePreparationError < OpenAI::Errors::Error
          attr_reader :prepared

          # @api private
          def initialize(prepared:)
            @prepared = prepared
            super("Agent file preparation failed; prepared contains the uploaded file references")
          end
        end

        # @api private
        class FilePreparation
          def initialize(client:, environment_files:)
            @client = client
            @environment_files = environment_files
          end

          def prepare(files, request_options: {})
            prepare_sources(files, request_options: request_options)
          end

          private def prepare_sources(files, request_options:, directory_root: nil)
            entries = files.map do |destination, source|
              path = local_file(source)
              stat = path.lstat
              check_directory_source(path, directory_root) if directory_root
              [destination_path(destination), path, stat]
            end

            if entries.length > 1 && explicit_idempotency_key?(request_options)
              raise ArgumentError, "Use separate uploads when supplying an Idempotency-Key for multiple files"
            end

            paths = entries.map(&:first)
            if paths.uniq.length != paths.length ||
                paths.combination(2).any? { |a, b| a.start_with?("#{b}/") || b.start_with?("#{a}/") }
              raise ArgumentError, "Destination file paths must not collide"
            end

            upload_options = entries.one? ? request_options_scope(request_options).child("file-upload") : request_options
            uploaded = []
            begin
              Dir.mktmpdir("openai-agent-files") do |directory|
                snapshots = entries.each_with_index.map do |(destination, source, stat), index|
                  target = Pathname(directory).join(index.to_s)
                  snapshot(source, target, stat, directory_root)
                  [destination, OpenAI::FilePart.new(target, filename: source.basename.to_s)]
                end

                snapshots.each do |destination, source|
                  file = @client.files.create(file: source, purpose: :user_data, request_options: upload_options)
                  uploaded << {type: :file_id, file_id: file.id, path: destination}
                end
              end

              PreparedFiles.new(uploaded)
            rescue StandardError
              raise FilePreparationError.new(prepared: PreparedFiles.new(uploaded))
            end
          end

          def prepare_directory(directory, destination:, include:, request_options: {})
            root = Pathname(directory).expand_path
            identity = root.lstat
            unless identity.directory?
              raise ArgumentError, "directory must be an existing directory, not a symlink"
            end

            canonical = root.realpath
            unless [root.lstat, canonical.lstat].all? {
                _1.directory? && _1.dev == identity.dev && _1.ino == identity.ino
              }
              raise ArgumentError, "Selected directory changed while preparing files"
            end

            root = canonical
            directory_root = [root, identity.dev, identity.ino]
            patterns = Array(include)
            if patterns.empty? ||
                patterns.any? { !_1.is_a?(String) || _1.start_with?("/") || _1.split("/").include?("..") }
              raise ArgumentError, "include must contain relative selection patterns"
            end

            base = destination_path(destination, directory: true)
            selected = Dir.glob(patterns, base: root, flags: File::FNM_DOTMATCH).uniq.reject do |relative|
              root.join(relative).directory? && !root.join(relative).symlink?
            end

            prepare_sources(
              selected.to_h { |relative| ["#{base}/#{relative}", root.join(relative)] },
              request_options: request_options,
              directory_root: directory_root
            )
          end

          def upload(environment_id, file:, path:, request_options: {})
            scope = request_options_scope(request_options)
            prepared = prepare({path => file}, request_options: request_options)
            stage_options = scope.child("environment-file")
            begin
              @environment_files.create(
                environment_id,
                hosted_environment_file_param: prepared.files.first,
                request_options: stage_options.merge(
                  extra_headers: {"OpenAI-Beta" => "agents=v1"}.merge(stage_options[:extra_headers].to_h)
                )
              )
              prepared
            rescue StandardError
              raise FilePreparationError.new(prepared: prepared)
            end
          end

          private

          def request_options_scope(request_options)
            options = request_options.to_h
            headers = OpenAI::Internal::Util.normalized_headers(@client.headers, options[:extra_headers].to_h)
            if headers.key?("idempotency-key")
              options = options.merge(
                extra_headers: options[:extra_headers].to_h.merge("idempotency-key" => headers["idempotency-key"])
              )
            end

            OpenAI::Internal::RequestOptionsScope.new(options)
          end

          def snapshot(source, target, expected, directory_root)
            flags = File::RDONLY | File::NONBLOCK | File::BINARY
            flags |= File::NOFOLLOW if defined?(File::NOFOLLOW)
            File.open(source, flags) do |input|
              unless input.stat.file? && file_identity(input.stat) == file_identity(expected)
                raise ArgumentError, "Source changed after file preflight"
              end

              check_directory_source(source, directory_root) if directory_root
              copied = File.open(target, "wb") { |output| IO.copy_stream(input, output, expected.size + 1) }
              unless copied == expected.size && file_identity(input.stat) == file_identity(expected)
                raise ArgumentError, "Source changed while preparing files"
              end
            end
          end

          def check_directory_source(source, boundary)
            root, device, inode = boundary
            current = root.lstat
            unless current.directory? &&
                current.dev == device &&
                current.ino == inode &&
                source.to_s.start_with?(File.join(root, "")) &&
                source.realpath == source
              raise ArgumentError, "Selected directory changed or contains a symlink"
            end
          end

          def file_identity(stat) = [stat.dev, stat.ino, stat.size, stat.mtime, stat.ctime]

          def destination_path(path, directory: false)
            if path.is_a?(String)
              path = path.encoding == Encoding::BINARY ? path.dup.force_encoding(Encoding::UTF_8) : path.encode(
                Encoding::UTF_8
              )
              raise ArgumentError, "Destination must be valid UTF-8 text" unless path.valid_encoding?
            end

            parts = path.is_a?(String) ? path.split("/", -1) : []
            relative = parts.drop(2)
            root = relative.first
            unless path.is_a?(String) &&
                !path.include?("\0") &&
                !path.include?("\\") &&
                parts.first == "" &&
                parts[1] == "workspace" &&
                relative.none? { ["", ".", ".."].include?(_1) } &&
                (directory || !relative.empty?) &&
                ![".codex", ".managed-agents"].include?(root) &&
                !root.to_s.start_with?(".managed-agents-") &&
                (directory || relative != ["outputs"])
              raise ArgumentError, "Destination must be a normalized file path under /workspace"
            end

            path
          rescue EncodingError
            raise ArgumentError, "Destination must be valid UTF-8 text"
          end

          def local_file(source)
            path = Pathname(source).expand_path
            unless path.file? && !path.symlink?
              raise ArgumentError, "Sources must be regular files, not symlinks"
            end

            path
          end

          def explicit_idempotency_key?(options)
            opts = options.to_h
            headers = OpenAI::Internal::Util.normalized_headers(@client.headers, opts[:extra_headers].to_h)
            headers.key?("idempotency-key") ? headers["idempotency-key"] : opts[:idempotency_key]
          end
        end
      end
    end
  end
end
