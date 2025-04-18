# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # @see OpenAI::Resources::Beta::Threads::Runs::Steps#retrieve
          class StepRetrieveParams < OpenAI::Internal::Type::BaseModel
            # @!parse
            #   extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute thread_id
            #
            #   @return [String]
            required :thread_id, String

            # @!attribute run_id
            #
            #   @return [String]
            required :run_id, String

            # @!attribute [r] include
            #   A list of additional fields to include in the response. Currently the only
            #   supported value is `step_details.tool_calls[*].file_search.results[*].content`
            #   to fetch the file search result content.
            #
            #   See the
            #   [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
            #   for more information.
            #
            #   @return [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>, nil]
            optional :include,
                     -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Models::Beta::Threads::Runs::RunStepInclude] }

            # @!parse
            #   # @return [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>]
            #   attr_writer :include

            # @!method initialize(thread_id:, run_id:, include: nil, request_options: {})
            #   @param thread_id [String]
            #   @param run_id [String]
            #   @param include [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>]
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
