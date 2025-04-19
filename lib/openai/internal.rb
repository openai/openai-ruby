# frozen_string_literal: true

module OpenAI
  module Internal
    OMIT =
      Object.new.tap do
        _1.define_singleton_method(:inspect) { "#<#{OpenAI::Internal}::OMIT>" }
      end
        .freeze
  end
end
