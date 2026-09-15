# typed: true
# frozen_string_literal: true

# The standalone example check omits dependency RBIs. These are the optional
# Async constants used by SIP cleanup; async-websocket supplies them at runtime.
module Async
  class Task
    def self.current?
    end
  end

  # Async cancellation intentionally bypasses StandardError; mirror the external type.
  # rubocop:disable Lint/InheritException
  class Stop < Exception
  end
  # rubocop:enable Lint/InheritException
end
