# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class HostedPlugin < OpenAI::Internal::Type::BaseModel
        # @!attribute description
        #   The installed plugin description.
        #
        #   @return [String]
        required :description, String

        # @!attribute name
        #   The installed plugin name.
        #
        #   @return [String]
        required :name, String

        # @!attribute type
        #   The type of the object. Always `inline`.
        #
        #   @return [Symbol, :inline]
        required :type, const: :inline

        # @!method initialize(description:, name:, type: :inline)
        #   A plugin installed from an inline ZIP archive.
        #
        #   @param description [String]
        #     The installed plugin description.
        #
        #   @param name [String]
        #     The installed plugin name.
        #
        #   @param type [Symbol, :inline]
        #     The type of the object. Always `inline`.
      end
    end
  end
end
