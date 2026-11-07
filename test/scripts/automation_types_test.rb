# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "open3"
require "pathname"
require "tmpdir"
require "yaml"

load(File.expand_path("../../scripts/validate-rbs", __dir__))

class AutomationTypesTest < Minitest::Test
  ROOT = Pathname(__dir__).join("../..").expand_path
  SOURCE = <<~RUBY_SOURCE
    # typed: strict
    client = OpenAI::Client.new(api_key: "offline-typecheck-only")
    target = OpenAI::Beta::Agents::AutomationTargetParam::ExistingSession.new(session_id: "sess_test", instructions: "offline")
    periodic = OpenAI::Beta::Agents::AutomationScheduleParam::Periodic.new(name: "periodic", expression: "0 9 * * *", timezone: "UTC", target: target)
    once = OpenAI::Beta::Agents::AutomationScheduleParam::Once.new(name: "once", run_at: 1800000000, target: target)
    [periodic, once].each do |schedule|
      params = OpenAI::Beta::Agents::AutomationCreateParams.new(create_automation_params: schedule)
      client.beta.agents.automations.create(**params.to_hash)
    end
  RUBY_SOURCE

  def test_sorbet_accepts_typed_keyword_params
    output, status = check_types(SOURCE, :sorbet)
    assert_predicate(status, :success?, output)
    output, status = check_types(SOURCE.sub("create(**params.to_hash)", "create(params)"), :sorbet)
    refute_predicate(status, :success?, output)
    assert_includes(output, "Too many positional arguments")
  end

  def test_rbs_accepts_typed_keyword_params
    output, status = check_types(SOURCE, :rbs)
    assert_predicate(status, :success?, output)
    output, status = check_types(SOURCE.sub("create(**params.to_hash)", "create(params)"), :rbs)
    refute_predicate(status, :success?, output)
    assert_includes(output, "UnexpectedPositionalArgument")
  end

  private

  def check_types(source, checker)
    Dir.mktmpdir("automation-types") do |directory|
      path = Pathname(directory).join("consumer.rb")
      path.write(source)
      if checker == :sorbet
        return Open3.capture2e(
          {"SRB_SKIP_GEM_RBIS" => "1"},
          "srb",
          "tc",
          "--no-config",
          "--dir",
          ROOT.join("rbi").to_s,
          path.to_s
        )
      end

      dependencies = YAML.safe_load_file(ROOT.join("manifest.yaml")).fetch("dependencies")
      libraries = ["net-http", *(dependencies - %w[English etc net/http rbconfig set stringio])]
      # Like validate-rbs, avoid checking reopened namespaces once per signature file.
      signatures = ROOT.glob("sig/**/*.rbs").sort.map(&:read)
      refute(signatures.any? { |text| text.match?(OpenAI::RBSValidation::FILE_SCOPED_DIRECTIVE) })
      signature_dir = Pathname(directory).join("sig")
      signature_dir.mkpath
      signature_dir.join("all.rbs").write(signatures.join("\n"))
      Pathname(directory).join("Steepfile").write(
        <<~CONFIG
          target :consumer do
            signature "sig"
            check "consumer.rb"
            #{libraries.inspect}.each { |name| library(name) }
          end
        CONFIG
      )
      # validate:rbs validates all signatures; this test checks consumer calls against them.
      Open3.capture2e("steep", "check", "--validate=skip", "-j", "1", chdir: directory)
    end
  end
end
