# frozen_string_literal: true

require_relative "../../openai"
require_relative "local_audio/errors"
require_relative "local_audio/process"
require "tempfile"

module OpenAI
  # Optional local microphone and speaker helpers. Loading this file opens no devices.
  module LocalAudio
    class << self
      # Record a finite mono 24 kHz WAV, ready for a multipart audio upload.
      # @return [OpenAI::FilePart]
      def record(duration:, device: nil, timeout: nil)
        seconds = MediaProcess.duration(duration, name: :duration)
        MediaProcess.duration(timeout, name: :timeout) if timeout
        format, source = capture_device(device)
        reader, writer = IO.pipe(binmode: true)
        child = nil
        begin
          child = MediaProcess.new(
            [
              "ffmpeg",
              "-nostdin",
              "-hide_banner",
              "-loglevel",
              "quiet",
              "-f",
              format,
              "-i",
              source,
              "-t",
              seconds.to_s,
              "-ar",
              "24000",
              "-ac",
              "1",
              "-acodec",
              "pcm_s16le",
              "-f",
              "s16le",
              "pipe:1"
            ],
            input: File::NULL,
            output: writer,
            timeout: timeout
          )
          writer.close
          pcm = +"".b
          while (chunk = child.read(reader))
            pcm << chunk
          end

          raise DeviceError, "Microphone capture failed." unless child.wait.success?
          raise DeviceError, "Microphone returned no complete audio samples." if pcm.empty? || pcm.bytesize.odd?
          audio = StringIO.new(wav_header(pcm.bytesize) << pcm)
          OpenAI::FilePart.new(audio, filename: "audio.wav", content_type: "audio/wav")
        ensure
          reader.close unless reader.closed?
          writer.close unless writer.closed?
          child&.close
        end
      end

      # Play encoded audio, or explicitly selected mono 24 kHz raw PCM16.
      # The source is consumed from its current position and remains caller-owned.
      # @return [nil]
      def play(source, format: :auto, timeout: nil)
        raise ArgumentError, "format must be :auto or :pcm" unless [:auto, :pcm].include?(format)
        MediaProcess.duration(timeout, name: :timeout) if timeout
        io = playback_source(source)
        reader, writer = IO.pipe(binmode: true)
        child = nil
        diagnostics = nil
        begin
          # FFplay can exit zero on decoder/device failure. Count error output
          # without exposing its contents; the private temporary file is removed.
          diagnostics = Tempfile.new("openai-playback-errors")
          args = ["ffplay", "-autoexit", "-nodisp", "-nostats", "-loglevel", "error", "-protocol_whitelist", "pipe"]
          args.concat(
            format == :pcm ? ["-f", "s16le", "-ar", "24000", "-ch_layout", "mono"] : [
              "-format_whitelist",
              "wav,mp3,ogg,aac,flac"
            ]
          )
          child = MediaProcess.new(
            args + ["-i", "pipe:0"], input: reader, output: File::NULL, error: diagnostics, timeout: timeout
          )
          reader.close
          bytes = 0
          while (chunk = child.read(io))
            break if chunk.empty?
            bytes += chunk.bytesize
            child.write(writer, chunk)
          end

          raise PlaybackError, "Audio input is empty." if bytes.zero?
          raise FormatError, "PCM input ends with an incomplete sample." if format == :pcm && bytes.odd?
          writer.close
          status = child.wait
          raise PlaybackError, "Audio playback failed." unless status.success? && diagnostics.size.zero?
          nil
        ensure
          reader.close unless reader.closed?
          writer.close unless writer.closed?
          child&.close
          diagnostics&.close!
        end
      end

      # @api private
      def playback_source(source)
        content = source.is_a?(OpenAI::FilePart) ? source.content : source
        return content if content.is_a?(IO) || content.is_a?(StringIO)
        return StringIO.new(content) if source.is_a?(OpenAI::FilePart) && content.is_a?(String)
        raise ArgumentError, "source must be IO, StringIO, or a FilePart containing IO or bytes"
      end

      # @api private
      def capture_device(device, platform: RUBY_PLATFORM)
        unless device.nil? || device.is_a?(String) || (device.is_a?(Integer) && device >= 0)
          raise ArgumentError, "device must be a device name or nonnegative index"
        end

        raise ArgumentError, "invalid device identifier" if device.to_s.include?("\0") || device == ""
        case platform
        when /darwin/
          ["avfoundation", "none:#{device || "default"}"]
        when /linux/
          ["alsa", device.is_a?(Integer) ? "hw:#{device}" : (device || "default")]
        when /mswin|mingw|cygwin/
          raise ArgumentError, "Windows capture requires an explicit audio device name" unless device.is_a?(String)
          ["dshow", "audio=#{device}"]
        else
          raise UnsupportedPlatformError, "Local capture is not supported on this platform."
        end
      end

      # @api private
      def wav_header(bytes)
        format = "fmt " + [16, 1, 1, 24_000, 48_000, 2, 16].pack("VvvVVvv")
        if bytes <= 0xFFFFFFFF - 36
          "RIFF" + [bytes + 36].pack("V") + "WAVE" + format + "data" + [bytes].pack("V")
        else
          "RF64" +
            [0xFFFFFFFF].pack("V") +
            "WAVEds64" +
            [28].pack("V") +
            [bytes + 72, bytes, bytes / 2, 0].pack("Q<Q<Q<V") +
            format +
            "data" +
            [0xFFFFFFFF].pack("V")
        end
      end
    end
  end
end
