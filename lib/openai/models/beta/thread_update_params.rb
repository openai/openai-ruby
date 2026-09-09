# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Threads#update
      class ThreadUpdateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute thread_id
        #
        #   @return [String]
        required :thread_id, String

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        #
        #   @return [Hash{Symbol=>String}, nil]
        optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

        # @!attribute tool_resources
        #   A set of resources that are made available to the assistant's tools in this
        #   thread. The resources are specific to the type of tool. For example, the
        #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
        #   tool requires a list of vector store IDs.
        #
        #   @return [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources, nil]
        optional :tool_resources, -> { OpenAI::Beta::ThreadUpdateParams::ToolResources }, nil?: true

        # @!method initialize(thread_id:, metadata: nil, tool_resources: nil, request_options: {})
        #   @param thread_id [String]
        #
        #   @param metadata [Hash{Symbol=>String}, nil]
        #     Set of 16 key-value pairs that can be attached to an object. This can be useful
        #     for storing additional information about the object in a structured format, and
        #     querying for objects via API or the dashboard.
        #
        #     Keys are strings with a maximum length of 64 characters. Values are strings with
        #     a maximum length of 512 characters.
        #
        #   @param tool_resources [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources, nil]
        #     A set of resources that are made available to the assistant's tools in this
        #     thread. The resources are specific to the type of tool. For example, the
        #     `code_interpreter` tool requires a list of file IDs, while the `file_search`
        #     tool requires a list of vector store IDs.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        class ToolResources < OpenAI::Internal::Type::BaseModel
          # @!attribute code_interpreter
          #
          #   @return [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter, nil]
          optional :code_interpreter, -> { OpenAI::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter }

          # @!attribute file_search
          #
          #   @return [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch, nil]
          optional :file_search, -> { OpenAI::Beta::ThreadUpdateParams::ToolResources::FileSearch }

          # @!method initialize(code_interpreter: nil, file_search: nil)
          #   A set of resources that are made available to the assistant's tools in this
          #   thread. The resources are specific to the type of tool. For example, the
          #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
          #   tool requires a list of vector store IDs.
          #
          #   @param code_interpreter [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter]
          #   @param file_search [OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch]

          # @see OpenAI::Models::Beta::ThreadUpdateParams::ToolResources#code_interpreter
          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            # @!attribute file_ids
            #   A list of [file](https://developers.openai.com/api/reference/resources/files)
            #   IDs made available to the `code_interpreter` tool. There can be a maximum of 20
            #   files associated with the tool.
            #
            #   @return [Array<String>, nil]
            optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(file_ids: nil)
            #   @param file_ids [Array<String>]
            #     A list of [file](https://developers.openai.com/api/reference/resources/files)
            #     IDs made available to the `code_interpreter` tool. There can be a maximum of 20
            #     files associated with the tool.
          end

          # @see OpenAI::Models::Beta::ThreadUpdateParams::ToolResources#file_search
          class FileSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute vector_store_ids
            #   The
            #   [vector store](https://developers.openai.com/api/reference/resources/vector_stores)
            #   attached to this thread. There can be a maximum of 1 vector store attached to
            #   the thread.
            #
            #   @return [Array<String>, nil]
            optional :vector_store_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(vector_store_ids: nil)
            #   @param vector_store_ids [Array<String>]
            #     The
            #     [vector store](https://developers.openai.com/api/reference/resources/vector_stores)
            #     attached to this thread. There can be a maximum of 1 vector store attached to
            #     the thread.
          end
        end
      end
    end
  end
end
