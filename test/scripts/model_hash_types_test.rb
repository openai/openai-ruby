# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "open3"
require "pathname"
require "rbs"
require "tmpdir"

class ModelHashTypesTest < Minitest::Test
  ROOT = Pathname(__dir__).join("../..").expand_path

  def test_rbs_optional_keys_are_distinct_from_nullable_values
    output_paths = %w[
      responses/response_function_tool_call_output_item
      beta/beta_response_function_tool_call_output_item
    ]
    input_paths = %w[responses/response_input_item beta/beta_response_input_item]
    records = output_paths.map.with_index do |path, index|
      record = hash_type(
        path,
        index.zero? ? "ResponseFunctionToolCallOutputItem" : "BetaResponseFunctionToolCallOutputItem"
      )
      assert(record.fields.key?(:id))
      assert(record.optional_fields.key?(:call_id))
      refute_instance_of(RBS::Types::Optional, record.optional_fields.fetch(:call_id))
      assert(record.optional_fields.key?(:type), "defaulted tags may be omitted")
      ["output#{index}", project_record(record, :id, :call_id)]
    end

    input_paths.each_with_index do |path, index|
      record = hash_type(path, "FunctionCallOutput")
      assert_instance_of(RBS::Types::Optional, record.optional_fields.fetch(:call_id))
      records << ["input#{index}", project_record(record, :call_id)]
    end

    response = hash_type("responses/response", "Response")
    assert_instance_of(RBS::Types::Optional, response.fields.fetch(:temperature))
    records << ["required_nullable", project_record(response, :temperature)]

    signature = records.map { |name, record| "type #{name} = #{record}" }.join("\n")
    signature += "\nclass Contract\n"
    records.each { |name, _record| signature += "  def self.#{name}: (#{name}) -> void\n" }
    signature += "end\n"
    valid = <<~RUBY
      Contract.output0({id: "item"})
      Contract.output1({id: "item", call_id: "call"})
      Contract.input0({})
      Contract.input1({call_id: nil})
      Contract.required_nullable({temperature: nil})
    RUBY
    stdout, stderr, status = typecheck(signature, valid)
    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")

    invalid = <<~RUBY
      Contract.output0({id: "item", call_id: nil})
      Contract.output1({})
      Contract.input0({call_id: 123})
      Contract.required_nullable({temperature: "invalid"})
    RUBY
    stdout, stderr, status = typecheck(signature, invalid)
    refute_predicate(status, :success?, "#{stdout}\n#{stderr}")
    assert_equal(4, stdout.scan("Ruby::ArgumentTypeMismatch").size, "#{stdout}\n#{stderr}")
  end

  def test_parameter_alias_does_not_require_legacy_request_options
    source = ROOT.join("sig/openai/models/model_list_params.rbs").read
    nodes = declarations(RBS::Parser.parse_signature(source).last)
    alias_type = nodes.grep(RBS::AST::Declarations::TypeAlias).first.type
    # Deliberately retain the old shared alias: generated params must describe
    # omission independently of a handwritten runtime signature update.
    signature = <<~RBS
      module OpenAI
        type request_opts = ::Hash[Symbol, untyped]
        module Internal
          module Type
            type request_parameters = { request_options: ::OpenAI::request_opts }
          end
        end
      end
      type params = #{alias_type}
      class Contract
        def self.params: (params) -> void
      end
    RBS
    stdout, stderr, status = typecheck(
      signature,
      "Contract.params({})\nContract.params({request_options: {timeout: 1.0}})\n"
    )
    assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
  end

  private

  def declarations(nodes)
    nodes.flat_map do |node|
      children = node.respond_to?(:members) ? declarations(node.members) : []
      [node, *children]
    end
  end

  def hash_type(path, class_name)
    source = ROOT.join("sig/openai/models/#{path}.rbs").read
    nodes = declarations(RBS::Parser.parse_signature(source).last)
    model = nodes.find { |node| node.is_a?(RBS::AST::Declarations::Class) && node.name.name.to_s == class_name }
    refute_nil(model, class_name)
    method = model.members.find { |member|
      member.is_a?(RBS::AST::Members::MethodDefinition) && member.name == :to_hash
    }
    refute_nil(method, "#{class_name}#to_hash")
    record = method.overloads.first.method_type.type.return_type
    assert_instance_of(RBS::Types::Record, record)
    # Model record aliases must describe the same keys and values as to_hash.
    aliases = nodes.grep(RBS::AST::Declarations::TypeAlias).map(&:type)
    assert_includes(aliases, record)
    record
  end

  def project_record(record, *keys)
    RBS::Types::Record.new(all_fields: record.all_fields.slice(*keys), location: nil)
  end

  def typecheck(signature, source)
    Dir.mktmpdir("model-hash-types") do |directory|
      root = Pathname(directory)
      root.join("sig").mkpath
      root.join("sig/contract.rbs").write(signature)
      root.join("probe.rb").write(source)
      root.join("Steepfile").write(
        <<~RUBY
          target :probe do
            signature "sig"
            check "probe.rb"
          end
        RUBY
      )
      Open3.capture3("steep", "check", "--jobs=1", chdir: directory)
    end
  end
end
