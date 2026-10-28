# frozen_string_literal: true

require "open3"
require "tempfile"

require_relative "test_helper"

class OpenAI::Test::DecisionsInputSorbetTest < Minitest::Test
  extend Minitest::Serial

  def test_documented_message_migration_accepts_all_roles
    root = File.expand_path("../..", __dir__)
    source = File.read(File.join(root, "test/fixtures/rbs_compatibility/decisions_message_migration_valid.rb.txt"))
    Tempfile.create(["decisions-message-migration", ".rb"]) do |file|
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
end
