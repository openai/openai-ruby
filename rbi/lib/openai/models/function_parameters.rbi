# typed: strong

module OpenAI
  module Models
    FunctionParameters = T.type_alias { T::Hash[Symbol, T.anything] }
  end
end
