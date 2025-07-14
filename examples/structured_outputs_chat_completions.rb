#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strong

require_relative "../lib/openai"

class Location < OpenAI::BaseModel
  required :address, String
  required :city, String, doc: "City name"
  required :postal_code, String, nil?: true
end

# Participant model with an optional last_name and an enum for status
class Participant < OpenAI::BaseModel
  required :first_name, String
  required :last_name, String, nil?: true
  required :status, OpenAI::EnumOf[:confirmed, :unconfirmed, :tentative]
end

# CalendarEvent model with a list of participants.
class CalendarEvent < OpenAI::BaseModel
  required :name, String
  required :date, String
  required :participants, OpenAI::ArrayOf[Participant]
  required :optional_participants, OpenAI::ArrayOf[Participant], nil?: true
  required :is_virtual, OpenAI::Boolean
  required :location,
           OpenAI::UnionOf[String, Location],
           nil?: true,
           doc: "Event location"
end

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

chat_completion = client.chat.completions.create(
  model: "gpt-4o-2024-08-06",
  messages: [
    {role: :system, content: "Extract the event information."},
    {
      role: :user,
      content: <<~CONTENT
        Alice Shah and Lena are going to a science fair on Friday at 123 Main St. in San Diego.
        They have also invited Jasper Vellani and Talia Groves - Jasper has not responded and Talia said she is thinking about it.
      CONTENT
    }
  ],
  response_format: CalendarEvent
)

chat_completion
  .choices
  .reject { _1.message.refusal }
  .each do |choice|
    # parsed is an instance of `CalendarEvent`
    pp(choice.message.parsed)
  end
