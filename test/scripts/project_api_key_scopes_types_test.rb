# frozen_string_literal: true

require "minitest/autorun"
require "open3"
require "pathname"
require "rbs"
require "tmpdir"

class ProjectAPIKeyScopesTypesTest < Minitest::Test
  ROOT = Pathname(__dir__).join("../..").expand_path

  def test_sorbet_accepts_optional_expiry_and_scope_updates
    source = <<~RUBY_SOURCE
      # typed: strict
      params = OpenAI::Admin::Organization::Projects::APIKeyUpdateParams.new(
        project_id: "project_test", api_key_id: "key_test", expires_in_seconds: 3600
      )
      T.assert_type!(params.expires_in_seconds, T.nilable(Integer))
      T.assert_type!(T.must(params.expires_in_seconds) + 60, Integer)
      client = OpenAI::Client.new(admin_api_key: "fake-admin-key")
      keys = client.admin.organization.projects.api_keys
      keys.update("key_test", project_id: "project_test", expires_in_seconds: 3600)
      keys.update("key_test", project_id: "project_test", scopes: ["api.all.read"])
      keys.update("key_test", project_id: "project_test", expires_in_seconds: 3600, scopes: [])
      update_params = OpenAI::Admin::Organization::Projects::APIKeyUpdateParams.new(
        project_id: "project_test", api_key_id: "key_test", scopes: ["api.all.read"]
      )
      T.assert_type!(update_params.expires_in_seconds, T.nilable(Integer))
      T.assert_type!(update_params.scopes, T.nilable(T::Array[String]))
      keys.update_scopes("key_test", project_id: "project_test", scopes: ["api.all.read"])
      keys.update_scopes("key_test", project_id: "project_test", scopes: [])
      scope_params = OpenAI::Admin::Organization::Projects::APIKeyUpdateScopesParams.new(
        project_id: "project_test", scopes: ["api.all.read"]
      )
      keys.update_scopes("key_test", **scope_params)
    RUBY_SOURCE
    output, status = sorbet(source)
    assert_predicate(status, :success?, output)
    output, status = sorbet(source.sub("scopes: [\"api.all.read\"]", "scopes: nil"))
    refute_predicate(status, :success?, output)
    assert_includes(output, "scopes")
  end

  def test_rbs_exposes_optional_expiry_and_scopes
    path = ROOT.join("sig/openai/models/admin/organization/projects/api_key_update_params.rbs")
    nodes = declarations(RBS::Parser.parse_signature(path.read).last)
    model = nodes.grep(RBS::AST::Declarations::Class).find { |node| node.name.name == :APIKeyUpdateParams }
    reader = model.members.grep(RBS::AST::Members::AttrReader).find { |node| node.name == :expires_in_seconds }
    assert_equal("Integer?", reader.type.to_s)
    method = model.members.grep(RBS::AST::Members::MethodDefinition).find { |node| node.name == :to_hash }
    shape = method.overloads.first.method_type.type.return_type
    assert_equal("Integer", shape.optional_fields.fetch(:expires_in_seconds).to_s)
    assert_equal("::Array[String]", shape.optional_fields.fetch(:scopes).to_s)
    refute(shape.fields.key?(:expires_in_seconds))
  end

  private

  def declarations(nodes)
    nodes.flat_map { |node| [node, *(node.respond_to?(:members) ? declarations(node.members) : [])] }
  end

  def sorbet(source)
    Dir.mktmpdir("api-key-scopes-types") do |directory|
      path = Pathname(directory).join("consumer.rb")
      path.write(source)
      Open3.capture2e(
        {"SRB_SKIP_GEM_RBIS" => "1"},
        "srb",
        "tc",
        "--no-config",
        "--dir",
        ROOT.join("rbi").to_s,
        path.to_s
      )
    end
  end
end
