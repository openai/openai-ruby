# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../../../lib/openai/helpers/local_audio"
require_relative "../../../lib/openai/helpers/local_audio/worker"
require "tmpdir"
require "rbconfig"

class OpenAI::Test::LocalAudioWorkerTest < Minitest::Test
  extend Minitest::Serial

  Worker = OpenAI::LocalAudio::Worker

  # A real subprocess exercises pipe ownership, independent cancellation and
  # blocked reads. A method_missing mock cannot model the OS descriptor boundary.
  def with_worker(body, mode: :playback)
    Dir.mktmpdir("openai-worker-test") do |directory|
      path = File.join(directory, "worker")
      File.write(path, "#!#{RbConfig.ruby}\nSTDOUT.sync = true\nputs '0 ready 0'\n#{body}")
      File.chmod(0o700, path)
      Worker.stub(:executable, path) do
        worker = Worker.new(mode: mode, device: nil, buffer_duration: 0.1)
        begin
          yield worker
        ensure
          worker.close
        end
      end
    end
  end

  def test_capture_starts_explicitly_and_stop_unblocks_reader
    script = <<~'RUBY'
      while (line = STDIN.gets)
        id, operation = line.split
        puts "#{id} started 0"
        STDOUT.write("0 pcm 960\n" + "\0" * 960) if operation == "start"
      end
    RUBY
    with_worker(script, mode: :capture) do |worker|
      worker.start
      generation, frame = worker.next_frame
      assert_equal(0, generation)
      assert_equal(960, frame.bytesize)
      assert(frame.frozen?)
      waiter = Thread.new { worker.next_frame }
      worker.close
      assert_nil(waiter.value)
    end
  end

  def test_playback_media_finish_and_device_drain
    script = <<~'RUBY'
      line = STDIN.gets
      puts "#{line.split.first} started 0"
      media = IO.new(2, "rb")
      total = 0
      while (header = media.read(8))
        id, length = header.unpack("VV")
        media.read(length)
        total += length
        puts "#{id} accepted #{length}"
        if length.zero?
          puts "0 finished #{total / 2}"
          break
        end
      end
      STDIN.read
    RUBY
    with_worker(script) do |worker|
      worker.start
      assert_equal(20_000, worker.write("\0" * 20_000))
      worker.finish
      assert_equal(10_000, worker.wait)
      assert_equal(10_000, worker.interrupt)
    end
  end

  def test_interrupt_does_not_wait_for_blocked_media_pipe
    script = <<~'RUBY'
      while (line = STDIN.gets)
        id, operation = line.split
        puts "#{id} #{operation == 'start' ? 'started' : 'interrupted'} 0"
      end
    RUBY
    with_worker(script) do |worker|
      worker.start
      writer = Thread.new do
        worker.write("\0" * 1_000_000)
      rescue OpenAI::LocalAudio::PlaybackInterruptedError => error
        error
      end

      assert_equal(0, worker.interrupt)
      assert(writer.join(2), "write should be released by interruption")
      assert_instance_of(OpenAI::LocalAudio::PlaybackInterruptedError, writer.value)
    end
  end

  def test_corrupt_frame_is_rejected_without_allocating_its_claimed_length
    with_worker("STDIN.gets; puts '0 pcm 99999999999'; STDIN.read", mode: :capture) do |worker|
      assert_raises(OpenAI::LocalAudio::WorkerError) { worker.start }
    end
  end
end
