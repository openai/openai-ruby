# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Models::BatchCreateParamsTest < Minitest::Test
  COMMON = {
    completion_window: :"24h",
    endpoint: :"/v1/responses",
    input_file_id: "file_123"
  }.freeze

  def test_nullable_metadata_preserves_explicit_nil_in_request_and_response_paths
    params = OpenAI::BatchCreateParams.new(**COMMON, metadata: nil)

    assert_nil(params.metadata)
    assert_nil(params[:metadata])
    assert_nil(params.to_h.fetch(:metadata))
    dumped, = OpenAI::BatchCreateParams.dump_request(params)
    assert_nil(dumped.fetch(:metadata))

    state = OpenAI::Internal::Type::Converter.new_coerce_state
    parsed = OpenAI::Internal::Type::Converter.coerce(
      OpenAI::BatchCreateParams,
      {**COMMON, metadata: nil},
      state: state
    )

    assert_nil(parsed.metadata)
    assert_nil(parsed.to_h.fetch(:metadata))
    assert_nil(state.fetch(:error))
  end

  def test_output_expires_after_is_omittable_but_not_nullable
    omitted = OpenAI::BatchCreateParams.new(**COMMON)

    assert_nil(omitted.output_expires_after)
    refute(omitted.to_h.key?(:output_expires_after))

    explicit = OpenAI::BatchCreateParams.new(**COMMON, output_expires_after: nil)

    assert_nil(explicit[:output_expires_after])
    assert_nil(explicit.to_h.fetch(:output_expires_after))
    error = assert_raises(OpenAI::Errors::ConversionError) { explicit.output_expires_after }
    assert_instance_of(TypeError, error.cause)
  end
end
