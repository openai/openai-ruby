# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::MinitestCompatibilityTest < Minitest::Test
  extend Minitest::Serial

  def test_serial_suites_override_the_current_runner_protocol
    assert_equal(:random, self.class.run_order)
    assert_equal(Minitest::Serial, self.class.method(:run).owner)
  end

  def test_extracted_mocks_preserve_delegation_and_expectations
    delegate = Object.new
    def delegate.transport_protocol = :delegated

    transport = Minitest::Mock.new(delegate)
    transport.expect(:execute, :response, [:request])

    assert_equal(:delegated, transport.transport_protocol)
    assert_equal(:response, transport.execute(:request))
    assert_mock(transport)
  end
end
