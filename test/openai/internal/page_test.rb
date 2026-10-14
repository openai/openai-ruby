# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::PageTest < Minitest::Test
  def test_next_page_is_unavailable
    page = OpenAI::Internal::Page.allocate

    refute(page.next_page?)
    error = assert_raises(RuntimeError) { page.next_page }
    assert_equal("No more pages available.", error.message)
  end
end
