# frozen_string_literal: true

module OpenAI
  module Examples
    module Realtime
      module AudioFiles
        module_function

        def open(input_path:, output_path:)
          File.open(input_path, "rb") do |input|
            output = open_output_for(input, output_path)
            begin
              yield(input, output)
            ensure
              output.close unless output.closed?
            end
          end
        end

        def open_output(input_path:, output_path:)
          File.open(input_path, "rb") do |input|
            return open_output_for(input, output_path)
          end
        end

        def validate!(input_path:, output_path:)
          File.open(input_path, "rb") do |input|
            next unless File.exist?(output_path)

            File.open(output_path, "rb") do |output|
              validate_distinct!(input, output)
            end
          end
          nil
        end

        private def open_output_for(input, output_path)
          output = File.open(output_path, File::WRONLY | File::CREAT, 0o666)
          prepared = false
          begin
            validate_distinct!(input, output)
            output.truncate(0)
            output.rewind
            prepared = true
          ensure
            output.close unless prepared
          end
          output
        end

        private def validate_distinct!(input, output)
          input_stat = input.stat
          output_stat = output.stat
          return unless input_stat.dev == output_stat.dev && input_stat.ino == output_stat.ino

          raise ArgumentError, "Realtime audio input and output must be different files"
        end
      end
    end
  end
end
