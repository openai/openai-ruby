# typed: strong

module OpenAI
  module Models
    module Realtime
      # Give the model access to additional tools via remote Model Context Protocol
      # (MCP) servers.
      # [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
      module RealtimeToolsConfigUnion
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeToolsConfigUnion::Function,
              OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp
            )
          end

        class Function < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeToolsConfigUnion::Function,
                OpenAI::Internal::AnyHash
              )
            end

          # The description of the function, including guidance on when and how to call it,
          # and guidance about what to tell the user when calling (if anything).
          sig { returns(T.nilable(String)) }
          attr_reader :description

          sig { params(description: String).void }
          attr_writer :description

          # The name of the function.
          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          # Parameters of the function in JSON Schema.
          sig { returns(T.nilable(T.anything)) }
          attr_reader :parameters

          sig { params(parameters: T.anything).void }
          attr_writer :parameters

          # The type of the tool, i.e. `function`.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeToolsConfigUnion::Function::Type::OrSymbol
              )
            )
          end
          attr_reader :type

          sig do
            params(
              type:
                OpenAI::Realtime::RealtimeToolsConfigUnion::Function::Type::OrSymbol
            ).void
          end
          attr_writer :type

          sig do
            params(
              description: String,
              name: String,
              parameters: T.anything,
              type:
                OpenAI::Realtime::RealtimeToolsConfigUnion::Function::Type::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The description of the function, including guidance on when and how to call it,
            # and guidance about what to tell the user when calling (if anything).
            description: nil,
            # The name of the function.
            name: nil,
            # Parameters of the function in JSON Schema.
            parameters: nil,
            # The type of the tool, i.e. `function`.
            type: nil
          )
          end

          sig do
            override.returns(
              {
                description: String,
                name: String,
                parameters: T.anything,
                type:
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Function::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The type of the tool, i.e. `function`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Function::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            FUNCTION =
              T.let(
                :function,
                OpenAI::Realtime::RealtimeToolsConfigUnion::Function::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Function::Type::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class Mcp < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp,
                OpenAI::Internal::AnyHash
              )
            end

          # A label for this MCP server, used to identify it in tool calls.
          sig { returns(String) }
          attr_accessor :server_label

          # The type of the MCP tool. Always `mcp`.
          sig { returns(Symbol) }
          attr_accessor :type

          # List of allowed tool names or a filter object.
          sig do
            returns(
              T.nilable(
                T.any(
                  T::Array[String],
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::AllowedTools::McpToolFilter
                )
              )
            )
          end
          attr_accessor :allowed_tools

          # An OAuth access token that can be used with a remote MCP server, either with a
          # custom MCP server URL or a service connector. Your application must handle the
          # OAuth authorization flow and provide the token here.
          sig { returns(T.nilable(String)) }
          attr_reader :authorization

          sig { params(authorization: String).void }
          attr_writer :authorization

          # Identifier for service connectors, like those available in ChatGPT. One of
          # `server_url` or `connector_id` must be provided. Learn more about service
          # connectors
          # [here](https://platform.openai.com/docs/guides/tools-remote-mcp#connectors).
          #
          # Currently supported `connector_id` values are:
          #
          # - Dropbox: `connector_dropbox`
          # - Gmail: `connector_gmail`
          # - Google Calendar: `connector_googlecalendar`
          # - Google Drive: `connector_googledrive`
          # - Microsoft Teams: `connector_microsoftteams`
          # - Outlook Calendar: `connector_outlookcalendar`
          # - Outlook Email: `connector_outlookemail`
          # - SharePoint: `connector_sharepoint`
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID::OrSymbol
              )
            )
          end
          attr_reader :connector_id

          sig do
            params(
              connector_id:
                OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID::OrSymbol
            ).void
          end
          attr_writer :connector_id

          # Optional HTTP headers to send to the MCP server. Use for authentication or other
          # purposes.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :headers

          # Specify which of the MCP server's tools require approval.
          sig do
            returns(
              T.nilable(
                T.any(
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter,
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalSetting::OrSymbol
                )
              )
            )
          end
          attr_accessor :require_approval

          # Optional description of the MCP server, used to provide more context.
          sig { returns(T.nilable(String)) }
          attr_reader :server_description

          sig { params(server_description: String).void }
          attr_writer :server_description

          # The URL for the MCP server. One of `server_url` or `connector_id` must be
          # provided.
          sig { returns(T.nilable(String)) }
          attr_reader :server_url

          sig { params(server_url: String).void }
          attr_writer :server_url

          # Give the model access to additional tools via remote Model Context Protocol
          # (MCP) servers.
          # [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
          sig do
            params(
              server_label: String,
              allowed_tools:
                T.nilable(
                  T.any(
                    T::Array[String],
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::AllowedTools::McpToolFilter::OrHash
                  )
                ),
              authorization: String,
              connector_id:
                OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID::OrSymbol,
              headers: T.nilable(T::Hash[Symbol, String]),
              require_approval:
                T.nilable(
                  T.any(
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::OrHash,
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalSetting::OrSymbol
                  )
                ),
              server_description: String,
              server_url: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # A label for this MCP server, used to identify it in tool calls.
            server_label:,
            # List of allowed tool names or a filter object.
            allowed_tools: nil,
            # An OAuth access token that can be used with a remote MCP server, either with a
            # custom MCP server URL or a service connector. Your application must handle the
            # OAuth authorization flow and provide the token here.
            authorization: nil,
            # Identifier for service connectors, like those available in ChatGPT. One of
            # `server_url` or `connector_id` must be provided. Learn more about service
            # connectors
            # [here](https://platform.openai.com/docs/guides/tools-remote-mcp#connectors).
            #
            # Currently supported `connector_id` values are:
            #
            # - Dropbox: `connector_dropbox`
            # - Gmail: `connector_gmail`
            # - Google Calendar: `connector_googlecalendar`
            # - Google Drive: `connector_googledrive`
            # - Microsoft Teams: `connector_microsoftteams`
            # - Outlook Calendar: `connector_outlookcalendar`
            # - Outlook Email: `connector_outlookemail`
            # - SharePoint: `connector_sharepoint`
            connector_id: nil,
            # Optional HTTP headers to send to the MCP server. Use for authentication or other
            # purposes.
            headers: nil,
            # Specify which of the MCP server's tools require approval.
            require_approval: nil,
            # Optional description of the MCP server, used to provide more context.
            server_description: nil,
            # The URL for the MCP server. One of `server_url` or `connector_id` must be
            # provided.
            server_url: nil,
            # The type of the MCP tool. Always `mcp`.
            type: :mcp
          )
          end

          sig do
            override.returns(
              {
                server_label: String,
                type: Symbol,
                allowed_tools:
                  T.nilable(
                    T.any(
                      T::Array[String],
                      OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::AllowedTools::McpToolFilter
                    )
                  ),
                authorization: String,
                connector_id:
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID::OrSymbol,
                headers: T.nilable(T::Hash[Symbol, String]),
                require_approval:
                  T.nilable(
                    T.any(
                      OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter,
                      OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalSetting::OrSymbol
                    )
                  ),
                server_description: String,
                server_url: String
              }
            )
          end
          def to_hash
          end

          # List of allowed tool names or a filter object.
          module AllowedTools
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  T::Array[String],
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::AllowedTools::McpToolFilter
                )
              end

            class McpToolFilter < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::AllowedTools::McpToolFilter,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Indicates whether or not a tool modifies data or is read-only. If an MCP server
              # is
              # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
              # it will match this filter.
              sig { returns(T.nilable(T::Boolean)) }
              attr_reader :read_only

              sig { params(read_only: T::Boolean).void }
              attr_writer :read_only

              # List of allowed tool names.
              sig { returns(T.nilable(T::Array[String])) }
              attr_reader :tool_names

              sig { params(tool_names: T::Array[String]).void }
              attr_writer :tool_names

              # A filter object to specify which tools are allowed.
              sig do
                params(
                  read_only: T::Boolean,
                  tool_names: T::Array[String]
                ).returns(T.attached_class)
              end
              def self.new(
                # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                # is
                # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                # it will match this filter.
                read_only: nil,
                # List of allowed tool names.
                tool_names: nil
              )
              end

              sig do
                override.returns(
                  { read_only: T::Boolean, tool_names: T::Array[String] }
                )
              end
              def to_hash
              end
            end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::AllowedTools::Variants
                ]
              )
            end
            def self.variants
            end

            StringArray =
              T.let(
                OpenAI::Internal::Type::ArrayOf[String],
                OpenAI::Internal::Type::Converter
              )
          end

          # Identifier for service connectors, like those available in ChatGPT. One of
          # `server_url` or `connector_id` must be provided. Learn more about service
          # connectors
          # [here](https://platform.openai.com/docs/guides/tools-remote-mcp#connectors).
          #
          # Currently supported `connector_id` values are:
          #
          # - Dropbox: `connector_dropbox`
          # - Gmail: `connector_gmail`
          # - Google Calendar: `connector_googlecalendar`
          # - Google Drive: `connector_googledrive`
          # - Microsoft Teams: `connector_microsoftteams`
          # - Outlook Calendar: `connector_outlookcalendar`
          # - Outlook Email: `connector_outlookemail`
          # - SharePoint: `connector_sharepoint`
          module ConnectorID
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            CONNECTOR_DROPBOX =
              T.let(
                :connector_dropbox,
                OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_GMAIL =
              T.let(
                :connector_gmail,
                OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_GOOGLECALENDAR =
              T.let(
                :connector_googlecalendar,
                OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_GOOGLEDRIVE =
              T.let(
                :connector_googledrive,
                OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_MICROSOFTTEAMS =
              T.let(
                :connector_microsoftteams,
                OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_OUTLOOKCALENDAR =
              T.let(
                :connector_outlookcalendar,
                OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_OUTLOOKEMAIL =
              T.let(
                :connector_outlookemail,
                OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID::TaggedSymbol
              )
            CONNECTOR_SHAREPOINT =
              T.let(
                :connector_sharepoint,
                OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # Specify which of the MCP server's tools require approval.
          module RequireApproval
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter,
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalSetting::TaggedSymbol
                )
              end

            class McpToolApprovalFilter < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter,
                    OpenAI::Internal::AnyHash
                  )
                end

              # A filter object to specify which tools are allowed.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Always
                  )
                )
              end
              attr_reader :always

              sig do
                params(
                  always:
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Always::OrHash
                ).void
              end
              attr_writer :always

              # A filter object to specify which tools are allowed.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Never
                  )
                )
              end
              attr_reader :never

              sig do
                params(
                  never:
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Never::OrHash
                ).void
              end
              attr_writer :never

              # Specify which of the MCP server's tools require approval. Can be `always`,
              # `never`, or a filter object associated with tools that require approval.
              sig do
                params(
                  always:
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Always::OrHash,
                  never:
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Never::OrHash
                ).returns(T.attached_class)
              end
              def self.new(
                # A filter object to specify which tools are allowed.
                always: nil,
                # A filter object to specify which tools are allowed.
                never: nil
              )
              end

              sig do
                override.returns(
                  {
                    always:
                      OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Always,
                    never:
                      OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Never
                  }
                )
              end
              def to_hash
              end

              class Always < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Always,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                # is
                # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                # it will match this filter.
                sig { returns(T.nilable(T::Boolean)) }
                attr_reader :read_only

                sig { params(read_only: T::Boolean).void }
                attr_writer :read_only

                # List of allowed tool names.
                sig { returns(T.nilable(T::Array[String])) }
                attr_reader :tool_names

                sig { params(tool_names: T::Array[String]).void }
                attr_writer :tool_names

                # A filter object to specify which tools are allowed.
                sig do
                  params(
                    read_only: T::Boolean,
                    tool_names: T::Array[String]
                  ).returns(T.attached_class)
                end
                def self.new(
                  # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                  # is
                  # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                  # it will match this filter.
                  read_only: nil,
                  # List of allowed tool names.
                  tool_names: nil
                )
                end

                sig do
                  override.returns(
                    { read_only: T::Boolean, tool_names: T::Array[String] }
                  )
                end
                def to_hash
                end
              end

              class Never < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Never,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                # is
                # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                # it will match this filter.
                sig { returns(T.nilable(T::Boolean)) }
                attr_reader :read_only

                sig { params(read_only: T::Boolean).void }
                attr_writer :read_only

                # List of allowed tool names.
                sig { returns(T.nilable(T::Array[String])) }
                attr_reader :tool_names

                sig { params(tool_names: T::Array[String]).void }
                attr_writer :tool_names

                # A filter object to specify which tools are allowed.
                sig do
                  params(
                    read_only: T::Boolean,
                    tool_names: T::Array[String]
                  ).returns(T.attached_class)
                end
                def self.new(
                  # Indicates whether or not a tool modifies data or is read-only. If an MCP server
                  # is
                  # [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                  # it will match this filter.
                  read_only: nil,
                  # List of allowed tool names.
                  tool_names: nil
                )
                end

                sig do
                  override.returns(
                    { read_only: T::Boolean, tool_names: T::Array[String] }
                  )
                end
                def to_hash
                end
              end
            end

            # Specify a single approval policy for all tools. One of `always` or `never`. When
            # set to `always`, all tools will require approval. When set to `never`, all tools
            # will not require approval.
            module McpToolApprovalSetting
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalSetting
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ALWAYS =
                T.let(
                  :always,
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalSetting::TaggedSymbol
                )
              NEVER =
                T.let(
                  :never,
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalSetting::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalSetting::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::Variants
                ]
              )
            end
            def self.variants
            end
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Realtime::RealtimeToolsConfigUnion::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
