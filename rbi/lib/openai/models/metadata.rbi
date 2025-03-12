# typed: strong

module OpenAI
  module Models
    Metadata = T.type_alias { T.nilable(T::Hash[Symbol, String]) }
  end
end
