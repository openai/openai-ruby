# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::PooledNetRequesterTest < Minitest::Test
  def test_with_pool_waits_indefinitely_when_deadline_is_nil
    requester = OpenAI::Internal::Transport::PooledNetRequester.new(size: 1)
    pool = ConnectionPool.new(size: 1, timeout: 0.05) { Object.new }
    origin = OpenAI::Internal::Util.uri_origin(URI("http://localhost"))
    requester.instance_variable_get(:@pools)[origin] = pool

    pool.checkout

    result = Queue.new
    waiter =
      Thread.new do
        begin
          requester.send(:with_pool, URI("http://localhost"), deadline: nil) { result << :acquired }
        rescue StandardError => e
          result << e
        end
      end

    sleep 0.15
    pool.checkin

    assert(waiter.join(1), "expected waiting thread to finish after the connection was returned")
    assert_equal(:acquired, result.pop)
  end
end
