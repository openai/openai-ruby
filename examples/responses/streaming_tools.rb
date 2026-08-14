#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: true

require_relative "../../lib/openai"

class DynamicValue < OpenAI::BaseModel
  required :column_name, String
end

class Condition < OpenAI::BaseModel
  required :column, String
  required :operator, OpenAI::EnumOf[:eq, :gt, :lt, :le, :ge, :ne]
  required :value, OpenAI::UnionOf[String, Integer, DynamicValue]
end

# you can assign `OpenAI::{...}` schema specifiers to a constant
Columns = OpenAI::EnumOf[
  :id,
  :status,
  :expected_delivery_date,
  :delivered_at,
  :shipped_at,
  :ordered_at,
  :canceled_at
]

class Query < OpenAI::BaseModel
  required :table_name, OpenAI::EnumOf[:orders, :customers, :products]
  required :columns, OpenAI::ArrayOf[Columns]
  required :conditions, OpenAI::ArrayOf[Condition]
  required :order_by, OpenAI::EnumOf[:asc, :desc]
end

client = OpenAI::Client.new

stream = client.responses.stream(
  model: "gpt-4o-2024-08-06",
  input: "look up all my orders in november of last year that were fulfilled but not delivered on time",
  tools: [Query],
  tool_choice: {type: :function, name: "Query"}
)

stream.each do |event|
  case event
  when OpenAI::Streaming::ResponseFunctionCallArgumentsDeltaEvent
    puts("delta: #{event.delta}")
    puts("snapshot: #{event.snapshot}")
  end
end

response = stream.get_final_response

puts
puts("----- parsed outputs from final response -----")
parsed_tool_call_received = T.let(false, T::Boolean)
response
  .output
  .each do |output|
    case output
    when OpenAI::Models::Responses::ResponseFunctionToolCall
      # parsed is an instance of `Query`
      parsed = T.cast(output.parsed, Query)

      parsed_tool_call_received = true
      pp(parsed)
    end
  end
abort("The final response did not contain a parsed Query tool call") unless parsed_tool_call_received
