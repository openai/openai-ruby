# frozen_string_literal: true

require "tempfile"

module OpenAI
  module Realtime
    # Receives media without waiting for the native playback ring. A single
    # playback thread feeds devices; disk buffering is explicitly caller-selected.
    # @api private
    class AudioOutput
      def initialize(device:, buffer_duration:, directory:, notifications:, control_timeout: 5, cleanup_timeout: 2)
        @mutex = Mutex.new
        @changed = ConditionVariable.new
        @items = []
        @all = {}
        @directory = directory
        @notifications = notifications
        @ready = Queue.new
        @thread = Thread.new do
          player = LocalAudio::Player.new(
            device: device,
            buffer_duration: buffer_duration,
            control_timeout: control_timeout,
            cleanup_timeout: cleanup_timeout
          )
          begin
            @ready << nil
            run(player)
          ensure
            player.close
          end

        rescue StandardError => error
          @ready << error
          @notifications << [:failure, error]
        ensure
          @mutex.synchronize { @all.each_value { |item| dispose(item) } }
        end

        @thread.report_on_exception = false
        error = @ready.pop
        raise error if error
      end

      def append(key, pcm)
        @mutex.synchronize do
          item = @all[key] ||= new_item(key)
          return if item[:cancelled]
          if item[:file]
            item[:file].seek(0, IO::SEEK_END)
            item[:file].write(pcm)
          else
            item[:chunks] << pcm
          end

          @changed.broadcast
        end
      end

      def finish(key)
        @mutex.synchronize do
          item = @all[key] ||= new_item(key)
          item[:finished] = true
          @changed.broadcast
        end
      end

      def interrupt
        playback = @mutex.synchronize do
          @all.each_value do |item|
            next if item[:position]
            item[:cancelled] = true
            unless item.equal?(@active)
              item[:position] = LocalAudio::PlaybackPosition.new(played_frames: 0)
              dispose(item)
            end
          end

          @changed.broadcast
          @active && @active[:playback]
        end

        position = playback&.interrupt
        @mutex.synchronize do
          @active[:position] ||= position if position && @active
          @all.transform_values do |item|
            item[:position] || LocalAudio::PlaybackPosition.new(played_frames: 0)
          end
        end
      end

      def release(keys)
        @mutex.synchronize do
          keys.each do |key|
            item = @all[key]
            next unless item && item[:position]
            dispose(item)
            @all.delete(key)
          end
        end
      end

      def close
        @mutex.synchronize {
          @closed = true
          @changed.broadcast
        }
        interrupt
        @thread.join
        nil
      end

      def inspect = "#<OpenAI::Realtime::AudioOutput>"

      private def new_item(key)
        item = {key: key, chunks: [], offset: 0, finished: false, cancelled: false}
        item[:file] = Tempfile.new(["openai-audio-", ".pcm"], @directory, binmode: true) if @directory
        @items << item
        item
      end

      private def run(player)
        loop do
          item = @mutex.synchronize do
            @changed.wait(@mutex) while @items.empty? && !@closed
            break if @closed
            @items.shift
          end

          break unless item
          if @mutex.synchronize do
              if item[:cancelled]
                dispose(item)
                true
              end
            end

            next
          end

          playback = player.begin_playback
          @mutex.synchronize {
            @active = item
            item[:playback] = playback
          }
          @notifications << [:playback_started, item[:key]]
          begin
            loop do
              chunk = next_chunk(item)
              break unless chunk
              playback.write(chunk)
            end

            if @mutex.synchronize { item[:cancelled] || @closed }
              position = playback.interrupt
            else
              position = playback.finish.wait
            end

          rescue LocalAudio::PlaybackInterruptedError
            position = playback.interrupt
          end

          @mutex.synchronize do
            item[:position] ||= position
            @active = nil
            item.delete(:playback)
            dispose(item)
          end

          @notifications << [:playback_finished, item[:key], position, item[:cancelled]]
        end
      end

      private def next_chunk(item)
        @mutex.synchronize do
          loop do
            return nil if item[:cancelled] || @closed
            chunk = if item[:file]
              item[:file].seek(item[:offset])
              bytes = item[:file].read(8192)
              item[:offset] += bytes.bytesize if bytes
              bytes
            else
              item[:chunks].shift
            end

            return chunk if chunk && !chunk.empty?
            return nil if item[:finished]
            @changed.wait(@mutex)
          end
        end
      end

      private def dispose(item)
        item[:chunks].clear
        item[:file]&.close!
        item[:file] = nil
      end
    end
  end
end
