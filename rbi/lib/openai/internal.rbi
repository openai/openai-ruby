# typed: strong

module OpenAI
  # @api private
  module Internal
    # Due to the current WIP status of Shapes support in Sorbet, types referencing
    #   this alias might be refined in the future.
    AnyHash = T.type_alias { T::Hash[Symbol, T.anything] }
  end
end
