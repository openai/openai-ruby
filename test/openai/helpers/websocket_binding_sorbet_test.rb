# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

class OpenAI::Test::WebSocketBindingSorbetTest < Minitest::Test
  def test_production_resources_preserve_generic_events_and_specialized_connections
    assert_typechecks(
      <<~RUBY
        # typed: strict
        client = OpenAI::Client.new
        client.realtime.translations.connect do |connection|
          T.assert_type!(connection.receive, T.nilable(T.any(OpenAI::Realtime::RealtimeTranslationServerEvent::Variants, T::Hash[Symbol, T.untyped])))
          connection.send_event(OpenAI::Realtime::RealtimeTranslationSessionCloseEvent.new)
          connection.send_event(type: "session.close")
          connection.each do |event|
            T.assert_type!(event, T.any(OpenAI::Realtime::RealtimeTranslationServerEvent::Variants, T::Hash[Symbol, T.untyped]))
          end
        end
        client.beta.responses.connect do |connection|
          T.assert_type!(connection.receive, T.nilable(T.any(OpenAI::Beta::BetaResponsesServerEvent::Variants, T::Hash[Symbol, T.untyped])))
          connection.send_event(type: "response.create")
        end
        client.realtime.connect(model: "synthetic") { |connection| T.assert_type!(connection, OpenAI::Realtime::Connection) }
        client.responses.connect { |connection| T.assert_type!(connection, OpenAI::Responses::Connection) }
        client.live.connect { |connection| T.assert_type!(connection, OpenAI::Live::Connection) }
        client.live.sideband.connect("session") { |connection| T.assert_type!(connection, OpenAI::Live::SidebandConnection) }
        client.live.forks.connect("session") { |connection| T.assert_type!(connection, OpenAI::Live::ForkConnection) }
      RUBY
    )
  end

  def test_production_generic_resource_rejects_wrong_event_models_and_receive_types
    output, status = typecheck(
      <<~RUBY
        # typed: strict
        OpenAI::Client.new.realtime.translations.connect do |connection|
          connection.send_event(OpenAI::Live::InputAudioMuteEvent.new)
          T.let(connection.receive, String)
        end
      RUBY
    )
    refute_predicate(status, :success?, output)
    assert_includes(output, "InputAudioMuteEvent")
    assert_includes(output, "send_event")
    assert_includes(output, "String")
    assert_includes(output, "Errors: 2")
  end

  def test_generic_connection_supports_enumerator_and_enumerable_methods
    source = <<~RUBY
      # typed: strict
      connection = T.let(T.unsafe(nil), OpenAI::WebSocket::TypedConnection[T.untyped, T.untyped])
      connection.each
      connection.each { |event| event }
      connection.map { |event| event }
    RUBY
    assert_typechecks(source)
  end

  # This is the class-side contract emitted for a generated binding. Keep this
  # consumer separate from the runtime fixture: RBI declarations are static only.
  BINDING = <<~RUBY
    module WebSocketTypingFixture
      class Resource
        include OpenAI::WebSocket::TypedResource
        extend T::Generic
        WebSocketClientEvent = type_member { {fixed: OpenAI::Realtime::RealtimeTranslationSessionCloseEvent} }
        WebSocketServerEvent = type_member { {fixed: T.any(OpenAI::Realtime::RateLimitsUpdatedEvent, T::Hash[Symbol, T.untyped])} }
      end
    end
  RUBY

  def test_binding_propagates_event_types_through_connect_receive_and_enumeration
    source = <<~RUBY
      # typed: strict
      #{BINDING}
      resource = T.let(T.unsafe(nil), WebSocketTypingFixture::Resource)
      resource.connect("workspace", query: {model: "synthetic"}, request_options: {timeout: 7.0}) do |connection|
        T.assert_type!(connection, OpenAI::WebSocket::TypedConnection[
          OpenAI::Realtime::RealtimeTranslationSessionCloseEvent,
          T.any(OpenAI::Realtime::RateLimitsUpdatedEvent, T::Hash[Symbol, T.untyped])
        ])
        T.assert_type!(connection.receive, T.nilable(T.any(OpenAI::Realtime::RateLimitsUpdatedEvent, T::Hash[Symbol, T.untyped])))
        T.assert_type!(connection.each.map { |event| event }, T::Array[T.any(OpenAI::Realtime::RateLimitsUpdatedEvent, T::Hash[Symbol, T.untyped])])
        connection.each do |event|
          T.assert_type!(event, T.any(OpenAI::Realtime::RateLimitsUpdatedEvent, T::Hash[Symbol, T.untyped]))
          if event.is_a?(Hash)
            T.assert_type!(event.keys, T::Array[Symbol])
          end
        end
        T.assert_type!(connection.map { |event| event }, T::Array[T.any(OpenAI::Realtime::RateLimitsUpdatedEvent, T::Hash[Symbol, T.untyped])])
        connection.send_event(OpenAI::Realtime::RealtimeTranslationSessionCloseEvent.new)
        connection.send_event(type: "future.event", extension: "keep")
        raw = T.let({"type" => "future.event"}, T::Hash[String, T.untyped])
        connection.send_event(raw)
        connection.close(code: 1000, reason: "done")
      end
    RUBY
    assert_typechecks(source)
  end

  def test_binding_rejects_wrong_models_and_preserves_incoming_type_errors
    source = <<~RUBY
      # typed: strict
      #{BINDING}
      resource = T.let(T.unsafe(nil), WebSocketTypingFixture::Resource)
      resource.connect do |connection|
        connection.send_event(123)
        connection.send_event(OpenAI::Live::InputAudioMuteEvent.new)
        T.let(connection.receive, String)
      end
    RUBY
    output, status = typecheck(source)
    refute_predicate(status, :success?, output)
    assert_includes(output, "Integer(123)")
    assert_includes(output, "InputAudioMuteEvent")
    assert_includes(output, "send_event")
    assert_includes(output, "String")
    assert_includes(output, "Errors: 3")
  end

  private def assert_typechecks(source)
    output, status = typecheck(source)
    assert_predicate(status, :success?, output)
  end

  private def typecheck(source)
    root = File.expand_path("../../..", __dir__)
    Tempfile.create(["websocket-binding-sorbet", ".rb"]) do |file|
      file.write(source)
      file.flush
      stdout, stderr, status = Open3.capture3({"SRB_SKIP_GEM_RBIS" => "1"}, "srb", "typecheck", file.path, chdir: root)
      ["#{stdout}\n#{stderr}", status]
    end
  end
end
