# typed: strong

module OpenAI
  module Models
    module Realtime
      class SidebandConnection < OpenAI::Realtime::Connection
        Elem =
          type_member { { fixed: OpenAI::Realtime::Connection::ServerEvent } }

        sig do
          returns(OpenAI::Realtime::ConnectionResources::OutputAudioBuffer)
        end
        attr_reader :output_audio_buffer

        # @api private
        sig do
          params(socket: T.untyped, url: URI::Generic).returns(T.attached_class)
        end
        def self.new(socket:, url:)
        end
      end
    end
  end
end
