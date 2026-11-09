# frozen_string_literal: true

require "pathname"
require "rbs"
require "tmpdir"

require_relative "../test_helper"

class OpenAI::Test::WebSocketBindingRBSTest < Minitest::Test
  def test_production_resources_substitute_endpoint_event_types
    loader = RBS::EnvironmentLoader.new
    loader.add(path: Pathname(__dir__).join("../../../sig").expand_path)
    loader.add(library: "net-http")
    loader.add(library: "uri")
    environment = RBS::Environment.from_loader(loader).resolve_type_names
    builder = RBS::DefinitionBuilder.new(env: environment)
    {
      "::OpenAI::Resources::Realtime::Translations" => "::OpenAI::Models::Realtime::realtime_translation",
      "::OpenAI::Resources::Beta::Responses" => "::OpenAI::Models::Beta::beta_responses"
    }.each do |resource_name, event_prefix|
      resource = builder.build_instance(RBS::TypeName.parse(resource_name))
      connect = resource.methods.fetch(:connect).method_types.fetch(0)
      connection_type = connect.block.type.required_positionals.fetch(0).type
      client_event = "#{event_prefix}_client_event"
      server_event = "#{event_prefix}_server_event | ::Hash[::Symbol, untyped]"
      assert_equal("::OpenAI::WebSocket::TypedConnection[#{client_event}, #{server_event}]", connection_type.to_s)
      definition = builder.build_instance(connection_type.name)
      connection = definition.sub(RBS::Substitution.build(definition.type_params, connection_type.args))
      assert_equal("(#{server_event})?", connection.methods.fetch(:receive).method_types.fetch(0).type.return_type.to_s)
    end
  end

  def test_binding_substitutes_event_types_through_the_inherited_connection_contract
    Dir.mktmpdir("websocket-binding-rbs") do |directory|
      signature = Pathname(directory).join("binding.rbs")
      signature.write(
        <<~RBS
          class WebSocketTypingFixture
            include OpenAI::WebSocket::TypedResource[
              OpenAI::Realtime::RealtimeTranslationSessionCloseEvent,
              OpenAI::Realtime::RateLimitsUpdatedEvent | Hash[Symbol, untyped]
            ]
          end
        RBS
      )
      loader = RBS::EnvironmentLoader.new
      loader.add(path: Pathname(__dir__).join("../../../sig").expand_path)
      loader.add(path: signature)
      loader.add(library: "net-http")
      environment = RBS::Environment.from_loader(loader).resolve_type_names
      builder = RBS::DefinitionBuilder.new(env: environment)
      resource = builder.build_instance(RBS::TypeName.parse("::WebSocketTypingFixture"))
      connect = resource.methods.fetch(:connect).method_types.fetch(0)
      connection_type = connect.block.type.required_positionals.fetch(0).type
      client_event = "::OpenAI::Models::Realtime::RealtimeTranslationSessionCloseEvent"
      server_event = "::OpenAI::Models::Realtime::RateLimitsUpdatedEvent | ::Hash[::Symbol, untyped]"
      assert_equal("::OpenAI::WebSocket::TypedConnection[#{client_event}, #{server_event}]", connection_type.to_s)

      definition = builder.build_instance(connection_type.name)
      connection = definition.sub(RBS::Substitution.build(definition.type_params, connection_type.args))
      assert_equal("(#{server_event})?", connection.methods.fetch(:receive).method_types.fetch(0).type.return_type.to_s)
      send_type = connection.methods.fetch(:send_event).method_types.fetch(0).type.required_positionals.fetch(0).type
      assert_equal("#{client_event} | ::Hash[::String | ::Symbol, untyped]", send_type.to_s)
      each = connection.methods.fetch(:each).method_types
      assert_equal("::Enumerator[#{server_event}, self]", each.fetch(0).type.return_type.to_s)
      assert_equal(server_event, each.fetch(1).block.type.required_positionals.fetch(0).type.to_s)
    end
  end
end
