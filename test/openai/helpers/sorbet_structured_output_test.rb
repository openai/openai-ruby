# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "../test_helper"

if ENV.fetch("OPENAI_SORBET_STRUCTURED_OUTPUT_CHILD", "0") == "1"
  require "openai/helpers/sorbet"

else
  class OpenAI::Test::SorbetStructuredOutputTest < Minitest::Test
    def test_optional_sorbet_adapter_contract_in_isolated_process
      root = File.expand_path("../../..", __dir__)
      stdout, stderr, status = Open3.capture3(
        {"OPENAI_SORBET_STRUCTURED_OUTPUT_CHILD" => "1", "RUBYOPT" => nil},
        RbConfig.ruby,
        "-I",
        "#{root}/lib",
        __FILE__
      )

      assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
      assert_match(/0 failures, 0 errors, 0 skips/, stdout)
    end

    def test_optional_helper_explains_missing_sorbet_runtime
      root = File.expand_path("../../..", __dir__)
      _stdout, stderr, status = Open3.capture3(
        {"RUBYOPT" => nil},
        RbConfig.ruby,
        "--disable-gems",
        "-I",
        "#{root}/lib",
        "-e",
        "require \"openai/helpers/sorbet\""
      )

      refute_predicate(status, :success?)
      assert_includes(stderr, "Sorbet structured outputs require the optional sorbet-runtime gem")
    end

    def test_shipped_rbi_types_both_structured_output_entry_points
      root = File.expand_path("../../..", __dir__)
      source = <<~RUBY
        # typed: strict

        class TypedParticipant < T::Struct
          const :name, String
        end

        class TypedEvent < T::Struct
          const :participants, T::Array[TypedParticipant]
        end

        class LookupModel < OpenAI::BaseModel
          required :participant_id, Integer
        end

        schema = OpenAI::StructuredOutput.from_sorbet(TypedEvent)
        client = OpenAI::Client.new(api_key: "test-key")
        response = client.responses.create(model: "gpt-4o-mini", input: "test", text: schema)
        message = response.output.grep(OpenAI::Responses::ResponseOutputMessage).fetch(0)
        output_text = message.content.grep(OpenAI::Responses::ResponseOutputText).fetch(0)
        event = T.cast(output_text.parsed, TypedEvent)
        T.assert_type!(event.participants.fetch(0).name, String)

        completion = client.chat.completions.create(
          model: "gpt-4o-mini",
          messages: [{role: :user, content: "test"}],
          response_format: schema
        )
        T.cast(completion.choices.fetch(0).message.parsed, TypedEvent)

        retrieved = client.responses.retrieve(
          "resp_123",
          tools: [{type: :function, function: {name: "custom_lookup", parameters: LookupModel}}]
        )
        T.assert_type!(retrieved, OpenAI::Responses::Response)
      RUBY

      Tempfile.create(["sorbet-structured-output", ".rb"]) do |file|
        file.write(source)
        file.flush
        stdout, stderr, status = Open3.capture3(
          {"SRB_SKIP_GEM_RBIS" => "1"},
          "srb",
          "typecheck",
          file.path,
          chdir: root
        )

        assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
      end
    end

    def test_shipped_rbs_types_both_structured_output_entry_points
      root = File.expand_path("../../..", __dir__)
      resources = {
        "OpenAI::Resources::Responses" => "text",
        "OpenAI::Resources::Chat::Completions" => "response_format"
      }

      resources.each do |resource, keyword|
        stdout, stderr, status = Open3.capture3(
          "rbs",
          "-I",
          "sig",
          "-r",
          "net-http",
          "method",
          resource,
          "create",
          chdir: root
        )

        assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
        assert_match(/#{keyword}: ::OpenAI::Helpers::StructuredOutput::SorbetAdapter/, stdout)
      end
    end
  end
end

if ENV.fetch("OPENAI_SORBET_STRUCTURED_OUTPUT_CHILD", "0") == "1"
  class OpenAI::Test::SorbetStructuredOutputContractTest < Minitest::Test
    extend Minitest::Serial
    include WebMock::API

    class Attendance < T::Enum
      enums do
        CONFIRMED = new("confirmed")
        TENTATIVE = new("tentative")
      end
    end

    class Participant < T::Struct
      const :display_name, String, name: "displayName"
      const :email, T.nilable(String)
      const :attendance, Attendance
      const :active, T::Boolean
    end

    class CalendarEvent < T::Struct
      const :title, String
      const :participants, T::Array[Participant]
      const :alternates, T::Array[T.nilable(Participant)]
      const :capacity, Integer
      const :duration, Float
    end

    class ReusedParticipants < T::Struct
      const :primary, Participant
      const :backup, Participant
    end

    class ReusedParticipantGroups < T::Struct
      const :first, ReusedParticipants
      const :second, ReusedParticipants
    end

    class UnsupportedUnion < T::Struct
      const :value, T.any(String, Integer)
    end

    class UnsupportedHash < T::Struct
      const :value, T::Hash[String, String]
    end

    class DuplicateWireNames < T::Struct
      const :first, String, name: "same"
      const :second, String, name: "same"
    end

    class NumericEnum < T::Enum
      enums do
        VALUE = new(1)
      end
    end

    class UnsupportedEnum < T::Struct
      const :value, NumericEnum
    end

    class RecursiveModel < T::Struct
      const :next_model, T.nilable(RecursiveModel)
    end

    class NullableContainers < T::Struct
      const :active, T.nilable(T::Boolean)
      const :values, T.nilable(T::Array[Integer])
      const :attendance, T.nilable(Attendance)
      const :count, Integer, default: 1
    end

    class ExistingInstanceFormat
      include OpenAI::Helpers::StructuredOutput::JsonSchemaConverter

      def name = "ExistingInstanceFormat"

      def to_json_schema = {type: "object", properties: {}, required: [], additionalProperties: false}
    end

    def before_all
      super
      WebMock.enable!
    end

    def after_all
      WebMock.disable!
      super
    end

    def setup
      super
      @client = OpenAI::Client.new(base_url: "http://localhost", api_key: "test-key")
      @adapter = OpenAI::StructuredOutput.from_sorbet(CalendarEvent)
    end

    def teardown
      WebMock.reset!
      super
    end

    def test_strict_schema_preserves_nested_types_aliases_nullability_and_enums
      schema = @adapter.to_json_schema
      participant_reference = schema.dig(:properties, :participants, :items)
      participant = schema.fetch(:$defs).fetch(".participants")
      alternate = schema.dig(:properties, :alternates, :items)

      assert_equal("CalendarEvent", @adapter.name.split("::").last)
      assert_equal("object", schema.fetch(:type))
      assert_equal(false, schema.fetch(:additionalProperties))
      assert_equal(%w[title participants alternates capacity duration], schema.fetch(:required))
      assert_equal({type: "string"}, schema.dig(:properties, :title))
      assert_equal({type: "integer"}, schema.dig(:properties, :capacity))
      assert_equal({type: "number"}, schema.dig(:properties, :duration))
      assert_equal(%w[displayName email attendance active], participant.fetch(:required))
      assert_equal(false, participant.fetch(:additionalProperties))
      assert_equal({type: "string"}, participant.dig(:properties, :displayName))
      assert_equal({type: %w[string null]}, participant.dig(:properties, :email))
      assert_equal({type: "string", enum: %w[confirmed tentative]}, participant.dig(:properties, :attendance))
      assert_equal({type: "boolean"}, participant.dig(:properties, :active))
      assert_equal({:$ref => "#/$defs/.participants"}, participant_reference)
      assert_equal([participant_reference, {type: "null"}], alternate.fetch(:anyOf))
      assert_equal(schema, OpenAI::Helpers::StructuredOutput::JsonSchemaConverter.to_json_schema(@adapter))
    end

    def test_repeated_nested_structs_are_compiled_once_and_share_schema_definitions
      original_properties = Participant.props
      compilations = 0
      properties = -> {
        compilations += 1
        original_properties
      }

      adapter = Participant.stub(:props, properties) do
        OpenAI::StructuredOutput.from_sorbet(ReusedParticipantGroups)
      end

      assert_equal(1, compilations)

      schema = adapter.to_json_schema
      definitions = schema.fetch(:$defs)
      group = definitions.fetch(".first")
      participant_reference = {:$ref => "#/$defs/.first~1.primary"}

      assert_equal([".first", ".first/.primary"], definitions.keys.sort)
      assert_equal({:$ref => "#/$defs/.first"}, schema.dig(:properties, :first))
      assert_equal({:$ref => "#/$defs/.first"}, schema.dig(:properties, :second))
      assert_equal(participant_reference, group.dig(:properties, :primary))
      assert_equal(participant_reference, group.dig(:properties, :backup))
    end

    def test_hydrates_nested_application_models_and_actual_enum_values
      parsed = OpenAI::Internal::Type::Converter.coerce(@adapter, event_payload)
      participant = parsed.participants.fetch(0)

      assert_instance_of(CalendarEvent, parsed)
      assert_instance_of(Participant, participant)
      assert_equal("Ada", participant.display_name)
      assert_nil(participant.email)
      assert_same(Attendance::CONFIRMED, participant.attendance)
      assert_equal(true, participant.active)
      assert_nil(parsed.alternates.fetch(0))
      assert_instance_of(Participant, parsed.alternates.fetch(1))
      assert_same(Attendance::TENTATIVE, parsed.alternates.fetch(1).attendance)
    end

    def test_float_fields_accept_integer_json_numbers
      payload = event_payload
      payload[:duration] = 2

      parsed = OpenAI::Internal::Type::Converter.coerce(@adapter, payload)

      assert_instance_of(Float, parsed.duration)
      assert_equal(2.0, parsed.duration)
    end

    def test_float_fields_reject_overflow_and_nonfinite_values
      [10 ** 400, Float::INFINITY, Float::NAN].each do |number|
        payload = event_payload
        payload[:duration] = number

        error = assert_raises(OpenAI::StructuredOutput::SorbetAdapter::HydrationError) do
          OpenAI::Internal::Type::Converter.coerce(@adapter, payload)
        end

        assert_includes(error.message, "duration")
        refute_includes(error.message, number.to_s)
        assert_nil(error.cause)
      end
    end

    def test_rejects_unsupported_model_shapes_before_sending_requests
      [String, UnsupportedUnion, UnsupportedHash, DuplicateWireNames, UnsupportedEnum, RecursiveModel].each do |model|
        error = assert_raises(ArgumentError) { OpenAI::StructuredOutput.from_sorbet(model) }

        assert_match(/#{model.name.split("::").last}/, error.message)
      end
    end

    def test_rejects_missing_nullable_values_and_invalid_nested_values
      cases = [
        [event_payload.tap { _1.fetch(:participants).first.delete(:email) }, "participants[0].email"],
        [event_payload.tap { _1.fetch(:participants).first[:active] = "yes" }, "participants[0].active"],
        [
          event_payload.tap { _1.fetch(:participants).first[:attendance] = "secret-enum-value" },
          "participants[0].attendance"
        ],
        [event_payload.tap { _1[:participants] = {} }, "participants"],
        [event_payload.tap { _1.fetch(:participants).first[:unknown] = "secret" }, "participants[0]"],
        [event_payload.tap { _1.fetch(:participants).first["email"] = nil }, "participants[0].email"]
      ]

      cases.each do |payload, path|
        error = assert_raises(OpenAI::StructuredOutput::SorbetAdapter::HydrationError) do
          OpenAI::Internal::Type::Converter.coerce(@adapter, payload)
        end

        assert_includes(error.message, path)
        refute_includes(error.message, "Ada")
        refute_includes(error.message, "secret")
        refute_includes(error.full_message, "secret")
        assert_nil(error.cause)
      end
    end

    def test_constructor_failures_do_not_expose_response_values_in_exception_causes
      [ArgumentError, RuntimeError].each do |error_type|
        rejecting_constructor = -> (**_attributes) { raise error_type, "secret-constructor-value" }

        CalendarEvent.stub(:new, rejecting_constructor) do
          error = assert_raises(OpenAI::StructuredOutput::SorbetAdapter::HydrationError) do
            OpenAI::Internal::Type::Converter.coerce(@adapter, event_payload)
          end

          assert_includes(error.message, "CalendarEvent")
          refute_includes(error.full_message, "secret-constructor-value")
          assert_nil(error.cause)
        end
      end
    end

    def test_field_hydration_errors_do_not_capture_active_sensitive_exception_causes
      cases = [
        event_payload.tap { _1.fetch(:participants).first.delete(:email) },
        event_payload.tap { _1.fetch(:participants).first["email"] = nil },
        event_payload.tap { _1.fetch(:participants).first[:unknown] = "secret-field-value" }
      ]

      begin
        raise RuntimeError, "secret-active-cause"
      rescue RuntimeError
        cases.each do |payload|
          error = assert_raises(OpenAI::StructuredOutput::SorbetAdapter::HydrationError) do
            OpenAI::Internal::Type::Converter.coerce(@adapter, payload)
          end

          refute_includes(error.full_message, "secret-active-cause")
          refute_includes(error.full_message, "secret-field-value")
          assert_nil(error.cause)
        end
      end
    end

    def test_constructor_hydration_errors_do_not_expose_response_values
      expected = OpenAI::StructuredOutput::SorbetAdapter::HydrationError.new("secret-constructor-value")
      rejecting_constructor = -> (**_attributes) { raise expected }

      CalendarEvent.stub(:new, rejecting_constructor) do
        actual = assert_raises(OpenAI::StructuredOutput::SorbetAdapter::HydrationError) do
          OpenAI::Internal::Type::Converter.coerce(@adapter, event_payload)
        end

        refute_same(expected, actual)
        assert_includes(actual.message, "CalendarEvent")
        refute_includes(actual.full_message, "secret-constructor-value")
        assert_nil(actual.cause)
      end
    end

    def test_enum_deserializer_failures_do_not_expose_response_values
      errors = [
        RuntimeError.new("secret-enum-value"),
        ArgumentError.new("secret-enum-value"),
        OpenAI::StructuredOutput::SorbetAdapter::HydrationError.new("secret-enum-value")
      ]

      errors.each do |original|
        rejecting_deserializer = -> (_value) { raise original }

        Attendance.stub(:deserialize, rejecting_deserializer) do
          actual = assert_raises(OpenAI::StructuredOutput::SorbetAdapter::HydrationError) do
            OpenAI::Internal::Type::Converter.coerce(@adapter, event_payload)
          end

          refute_same(original, actual)
          assert_includes(actual.message, "participants[0].attendance")
          refute_includes(actual.full_message, "secret-enum-value")
          assert_nil(actual.cause)
        end
      end
    end

    def test_nullable_booleans_arrays_and_defaults_remain_required
      adapter = OpenAI::StructuredOutput.from_sorbet(NullableContainers)
      schema = adapter.to_json_schema

      assert_equal(%w[active values attendance count], schema.fetch(:required))
      assert_equal({type: %w[boolean null]}, schema.dig(:properties, :active))
      assert_equal({type: %w[array null], items: {type: "integer"}}, schema.dig(:properties, :values))
      assert_equal(
        {anyOf: [{type: "string", enum: %w[confirmed tentative]}, {type: "null"}]},
        schema.dig(:properties, :attendance)
      )

      parsed = OpenAI::Internal::Type::Converter.coerce(
        adapter,
        {active: nil, values: nil, attendance: nil, count: 2}
      )

      assert_nil(parsed.active)
      assert_nil(parsed.values)
      assert_nil(parsed.attendance)
      assert_equal(2, parsed.count)

      error = assert_raises(OpenAI::StructuredOutput::SorbetAdapter::HydrationError) do
        OpenAI::Internal::Type::Converter.coerce(adapter, {active: nil, values: nil, attendance: nil})
      end

      assert_includes(error.message, "count")
    end

    def test_nil_and_malformed_json_keep_existing_parser_behavior
      malformed = JSON::ParserError.new("malformed")

      assert_nil(OpenAI::Internal::Type::Converter.coerce(@adapter, nil))
      assert_same(malformed, OpenAI::Internal::Type::Converter.coerce(@adapter, malformed))
    end

    def test_existing_transport_models_preserve_caller_owned_values
      input = [{content: "before", role: "user", type: "message"}]
      params = OpenAI::Responses::ResponseCreateParams.new(input: input, model: "gpt-4o-mini")

      input.first[:content] = "after"
      input << {content: "second", role: "user", type: "message"}

      dumped, = OpenAI::Responses::ResponseCreateParams.dump_request(params)

      assert_same(input, params.to_h.fetch(:input))
      assert_equal("after", dumped.fetch(:input).first.fetch(:content))
      assert_equal(2, dumped.fetch(:input).length)
    end

    def test_chat_completions_public_boundary_hydrates_sorbet_models
      stub_request(:post, "http://localhost/chat/completions").to_return_json(
        status: 200,
        body: {
          id: "chatcmpl_sorbet",
          choices: [
            {
              finish_reason: "stop",
              index: 0,
              message: {content: event_payload.to_json, role: "assistant"}
            }
          ],
          created: 1_700_000_000,
          model: "gpt-4o-mini",
          object: "chat.completion"
        }
      )

      response = @client.chat.completions.create(
        messages: [{content: "Generate an event", role: :user}],
        model: "gpt-4o-mini",
        response_format: @adapter
      )

      assert_requested(:post, "http://localhost/chat/completions") do |request|
        format = JSON.parse(request.body).fetch("response_format").fetch("json_schema")

        assert_equal("CalendarEvent", format.fetch("name"))
        assert_equal(true, format.fetch("strict"))
        assert_equal("object", format.fetch("schema").fetch("type"))
      end

      parsed = response.choices.first.message.parsed

      assert_instance_of(CalendarEvent, parsed)
      assert_same(Attendance::CONFIRMED, parsed.participants.first.attendance)
    end

    def test_chat_completions_streaming_rejects_sorbet_before_sending_a_request
      error = assert_raises(ArgumentError) do
        @client.chat.completions.stream(
          messages: [{content: "Generate an event", role: :user}],
          model: "gpt-4o-mini",
          response_format: @adapter
        )
      end

      assert_includes(error.message, "Sorbet structured-output models")
      assert_not_requested(:post, "http://localhost/chat/completions")
    end

    def test_chat_completions_reject_unsupported_sorbet_function_tools_before_sending_a_request
      tools = [
        @adapter,
        {type: :function, function: {name: "event", parameters: @adapter}},
        {"type" => "function", "function" => {"name" => "event", "parameters" => @adapter}}
      ]

      tools.each do |tool|
        error = assert_raises(ArgumentError) do
          @client.chat.completions.create(
            messages: [{content: "Generate an event", role: :user}],
            model: "gpt-4o-mini",
            tools: [tool]
          )
        end

        assert_includes(error.message, "function tools are not supported")
        assert_not_requested(:post, "http://localhost/chat/completions")
      end
    end

    def test_chat_completions_streaming_rejects_sorbet_function_tools_before_sending_a_request
      tools = [
        @adapter,
        {type: :function, function: {name: "event", parameters: @adapter}},
        {"type" => "function", "function" => {"name" => "event", "parameters" => @adapter}}
      ]

      tools.each do |tool|
        error = assert_raises(ArgumentError) do
          @client.chat.completions.stream(
            messages: [{content: "Generate an event", role: :user}],
            model: "gpt-4o-mini",
            tools: [tool]
          )
        end

        assert_includes(error.message, "Sorbet structured-output models")
        assert_not_requested(:post, "http://localhost/chat/completions")
      end
    end

    def test_chat_completions_raw_streaming_rejects_sorbet_before_sending_a_request
      formats = [{response_format: @adapter}, {tools: [@adapter]}]

      formats.each do |format|
        error = assert_raises(ArgumentError) do
          @client.chat.completions.stream_raw(
            messages: [{content: "Generate an event", role: :user}],
            model: "gpt-4o-mini",
            **format
          )
        end

        assert_includes(error.message, "Sorbet structured-output models")
        assert_not_requested(:post, "http://localhost/chat/completions")
      end
    end

    def test_chat_completions_streaming_preserves_existing_instance_based_formats
      stub_request(:post, "http://localhost/chat/completions").to_return(
        status: 200,
        headers: {"Content-Type" => "text/event-stream"},
        body: "data: [DONE]\n\n"
      )

      stream = @client.chat.completions.stream(
        messages: [{content: "Generate an event", role: :user}],
        model: "gpt-4o-mini",
        response_format: {
          type: :json_schema,
          json_schema: {name: "ExistingInstanceFormat", schema: ExistingInstanceFormat.new}
        }
      )

      assert_instance_of(OpenAI::Helpers::Streaming::ChatCompletionStream, stream)
      assert_requested(:post, "http://localhost/chat/completions")
    end

    def test_chat_completions_streaming_rejects_string_keyed_sorbet_formats
      params = {
        "messages" => [{"content" => "Generate an event", "role" => "user"}],
        "model" => "gpt-4o-mini",
        "response_format" => {
          "type" => "json_schema",
          "json_schema" => {"name" => "event", "schema" => @adapter}
        }
      }

      error = assert_raises(ArgumentError) { @client.chat.completions.stream(params) }

      assert_includes(error.message, "Sorbet structured-output models")
      assert_not_requested(:post, "http://localhost/chat/completions")
    end

    def test_chat_completions_streaming_rejects_sorbet_inside_typed_request_models
      schema = OpenAI::ResponseFormatJSONSchema::JSONSchema.new(name: "event", schema: @adapter)
      formats = [
        OpenAI::ResponseFormatJSONSchema.new(json_schema: schema),
        {type: :json_schema, json_schema: schema}
      ]

      formats.each do |format|
        error = assert_raises(ArgumentError) do
          @client.chat.completions.stream(
            messages: [{content: "Generate an event", role: :user}],
            model: "gpt-4o-mini",
            response_format: format
          )
        end

        assert_includes(error.message, "Sorbet structured-output models")
        assert_not_requested(:post, "http://localhost/chat/completions")
      end
    end

    def test_responses_streaming_rejects_sorbet_formats_before_sending_a_request
      formats = [
        @adapter,
        {format: @adapter},
        {format: {type: :json_schema, name: "event", schema: @adapter}},
        {"format" => {"type" => "json_schema", "name" => "event", "schema" => @adapter}}
      ]

      formats.each do |format|
        error = assert_raises(ArgumentError) do
          @client.responses.stream(model: "gpt-4o-mini", input: "Generate an event", text: format)
        end

        assert_includes(error.message, "Sorbet structured-output models")
        assert_not_requested(:post, "http://localhost/responses")
      end
    end

    def test_responses_reject_unsupported_sorbet_function_tools_before_sending_a_request
      tools = [
        @adapter,
        {type: :function, name: "event", parameters: @adapter},
        {type: :function, function: {name: "event", parameters: @adapter}},
        {"type" => "function", "function" => {"name" => "event", "parameters" => @adapter}},
        OpenAI::Responses::FunctionTool.new(name: "event", parameters: @adapter, strict: true)
      ]

      tools.each do |tool|
        error = assert_raises(ArgumentError) do
          @client.responses.create(model: "gpt-4o-mini", input: "Generate an event", tools: [tool])
        end

        assert_includes(error.message, "function tools are not supported")
        assert_not_requested(:post, "http://localhost/responses")
      end
    end

    def test_responses_streaming_rejects_sorbet_function_tools_before_sending_a_request
      tools = [
        @adapter,
        {type: :function, name: "event", parameters: @adapter},
        {type: :function, function: {name: "event", parameters: @adapter}},
        {"type" => "function", "function" => {"name" => "event", "parameters" => @adapter}},
        OpenAI::Responses::FunctionTool.new(name: "event", parameters: @adapter, strict: true)
      ]

      tools.each do |tool|
        error = assert_raises(ArgumentError) do
          @client.responses.stream(model: "gpt-4o-mini", input: "Generate an event", tools: [tool])
        end

        assert_includes(error.message, "Sorbet structured-output models")
        assert_not_requested(:post, "http://localhost/responses")
      end
    end

    def test_responses_raw_streaming_rejects_sorbet_before_sending_a_request
      formats = [{text: @adapter}, {tools: [@adapter]}]

      formats.each do |format|
        error = assert_raises(ArgumentError) do
          @client.responses.stream_raw(model: "gpt-4o-mini", input: "Generate an event", **format)
        end

        assert_includes(error.message, "Sorbet structured-output models")
        assert_not_requested(:post, "http://localhost/responses")
      end
    end

    def test_responses_streaming_rejects_sorbet_before_retrieving_a_response
      error = assert_raises(ArgumentError) do
        @client.responses.stream(response_id: "resp_secret", text: @adapter)
      end

      assert_includes(error.message, "Sorbet structured-output models")
      assert_not_requested(:get, "http://localhost/responses/resp_secret")
    end

    def test_responses_streaming_rejects_string_keyed_sorbet_before_dispatch
      create = {
        "model" => "gpt-4o-mini",
        "input" => "Generate an event",
        "tools" => [{"type" => "function", "parameters" => @adapter}]
      }
      retrieve = {"response_id" => "resp_secret", "text" => @adapter}

      [create, retrieve].each do |params|
        error = assert_raises(ArgumentError) { @client.responses.stream(params) }

        assert_includes(error.message, "Sorbet structured-output models")
      end

      assert_not_requested(:post, "http://localhost/responses")
      assert_not_requested(:get, "http://localhost/responses/resp_secret")
    end

    def test_responses_streaming_rejects_sorbet_inside_typed_request_models
      schema = OpenAI::Responses::ResponseFormatTextJSONSchemaConfig.new(name: "event", schema: @adapter)
      format = OpenAI::Responses::ResponseTextConfig.new(format_: schema)

      error = assert_raises(ArgumentError) do
        @client.responses.stream(model: "gpt-4o-mini", input: "Generate an event", text: format)
      end

      assert_includes(error.message, "Sorbet structured-output models")
      assert_not_requested(:post, "http://localhost/responses")
    end

    def test_responses_public_boundary_hydrates_sorbet_models
      stub_request(:post, "http://localhost/responses").to_return_json(
        status: 200,
        body: {
          id: "resp_sorbet",
          output: [
            {
              id: "msg_sorbet",
              content: [{annotations: [], text: event_payload.to_json, type: "output_text"}],
              role: "assistant",
              status: "completed",
              type: "message"
            }
          ]
        }
      )

      response = @client.responses.create(
        model: "gpt-4o-mini",
        input: "Generate an event",
        text: @adapter
      )

      assert_requested(:post, "http://localhost/responses") do |request|
        format = JSON.parse(request.body).fetch("text").fetch("format")

        assert_equal("CalendarEvent", format.fetch("name"))
        assert_equal(true, format.fetch("strict"))
        assert_equal("object", format.fetch("schema").fetch("type"))
      end

      parsed = response.output.first.content.first.parsed

      assert_instance_of(CalendarEvent, parsed)
      assert_equal("Ada", parsed.participants.first.display_name)
    end

    def test_responses_retrieve_hydrates_sorbet_text_models
      stub_request(:get, "http://localhost/responses/resp_sorbet_retrieve").to_return_json(
        status: 200,
        body: {
          id: "resp_sorbet_retrieve",
          status: "completed",
          output: [
            {
              id: "msg_sorbet_retrieve",
              content: [{annotations: [], text: event_payload.to_json, type: "output_text"}],
              role: "assistant",
              status: "completed",
              type: "message"
            }
          ]
        }
      )

      response = @client.responses.retrieve("resp_sorbet_retrieve", text: @adapter)
      parsed = response.output.first.content.first.parsed

      assert_instance_of(CalendarEvent, parsed)
      assert_equal("Ada", parsed.participants.first.display_name)
    end

    def test_responses_retrieve_accepts_frozen_ordinary_tool_hints
      stub_request(:get, "http://localhost/responses/resp_frozen_tools").to_return_json(
        status: 200,
        body: {id: "resp_frozen_tools", status: "completed", output: []}
      )

      tools = [ExistingInstanceFormat.new].freeze
      response = @client.responses.retrieve("resp_frozen_tools", tools: tools)

      assert_empty(response.output)
      assert_equal(1, tools.length)
    end

    def test_responses_retrieve_rejects_unsupported_sorbet_function_tools_before_sending_a_request
      error = assert_raises(ArgumentError) do
        @client.responses.retrieve("resp_secret", tools: [@adapter])
      end

      assert_includes(error.message, "function tools are not supported")
      assert_not_requested(:get, "http://localhost/responses/resp_secret")
    end

    def test_ordinary_sdk_loading_does_not_load_sorbet_runtime
      root = File.expand_path("../../..", __dir__)
      code = "require \"openai\"; abort(\"Sorbet was loaded\") if defined?(T)"
      _stdout, stderr, status = Open3.capture3(RbConfig.ruby, "-I", "#{root}/lib", "-e", code)

      assert(status.success?, stderr)
    end

    private def event_payload
      {
        title: "Meeting",
        participants: [
          {displayName: "Ada", email: nil, attendance: "confirmed", active: true}
        ],
        alternates: [
          nil,
          {displayName: "Grace", email: "grace@example.test", attendance: "tentative", active: false}
        ],
        capacity: 2,
        duration: 1.5
      }
    end
  end
end
