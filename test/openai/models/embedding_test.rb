# frozen_string_literal: true

require "yaml"

require_relative "../test_helper"

class OpenAI::Models::EmbeddingTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def setup
    super
    WebMock.enable!
  end

  def teardown
    WebMock.reset!
    WebMock.disable!
    super
  end

  def test_float_response
    response = create_embeddings([[0.5, -0.25]], :float)

    assert_equal([0.5, -0.25], response.data[0].embedding)
  end

  def test_base64_response
    values = ["AAAAPwAAgL4=", "invalid base64", "AQ=="]
    response = create_embeddings(values, :base64)

    assert_equal([0.5, -0.25], response.data[0].embedding)
    response.data[0].embedding[0] = 1.0
    assert_equal([1.0, -0.25], response.data[0].embedding)
    assert_equal([1.0, -0.25], restore_embedding(response.data[0]).embedding)
    assert_equal(values[0], response.data[0][:embedding])
    response.data[0].embedding = values[0]
    assert_equal([0.5, -0.25], response.data[0].embedding)
    response.data[0].embedding = [1.0]
    assert_equal([1.0], response.data[0].embedding)
    [1, 2].each do |index|
      assert_raises(OpenAI::Errors::ConversionError) { response.data[index].embedding }
      assert_equal(values[index], response.data[index][:embedding])
    end
  end

  def test_frozen_base64_response
    item = create_embeddings(["AAAAPwAAgL4="], :base64).data[0]
    restored = restore_embedding(item)

    [item.clone(freeze: true), item, restored].each do |embedding|
      embedding.freeze
      embedding.embedding[0] = 1.0
      assert_equal([1.0, -0.25], embedding.embedding)
    end
  end

  def test_edited_base64_response_equality
    item, malformed = create_embeddings(["AAAAPwAAgL4=", "invalid base64"], :base64).data
    copy = OpenAI::Models::Embedding.new(item.to_h)

    assert_equal(item, copy)
    item.embedding[0] = 1.0
    refute_equal(item, copy)
    refute_equal(copy, item)
    copy.embedding[0] = 1.0
    assert_equal(item, copy)
    assert_equal(item.hash, copy.hash)
    assert_equal(malformed, OpenAI::Models::Embedding.new(malformed.to_h))
  end

  private

  def restore_embedding(item)
    YAML.safe_load(YAML.dump(item), permitted_classes: [OpenAI::Models::Embedding, Symbol, TypeError])
  end

  def create_embeddings(values, format)
    stub_request(:post, "https://example.test/v1/embeddings").to_return_json(
      body: {
        object: "list",
        model: "text-embedding-3-small",
        usage: {prompt_tokens: 1, total_tokens: 1},
        data: values.each_with_index.map { |embedding, index|
          {embedding: embedding, index: index, object: "embedding"}
        }
      }
    )

    client = OpenAI::Client.new(api_key: "test-key", base_url: "https://example.test/v1")
    client.embeddings.create(input: "hello", model: "text-embedding-3-small", encoding_format: format)
  end
end
