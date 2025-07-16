#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strong

require_relative "../lib/openai"
require "base64"

client = OpenAI::Client.new

puts "Starting image streaming example..."

stream = client.images.generate_stream_raw(
  model: "gpt-image-1",
  prompt: "A cute baby sea otter",
  n: 1,
  size: "1024x1024",
  partial_images: 3
)

stream.each do |event|
  case event
  when OpenAI::Models::ImageGenPartialImageEvent
    puts("  Partial image #{event.partial_image_index + 1}/3 received")
    puts("  Size: #{event.b64_json.length} characters (base64)")

    # Save partial image to file
    filename = "partial_#{event.partial_image_index + 1}.png"
    image_data = Base64.decode64(event.b64_json)
    File.write(filename, image_data)
    puts("  Saved to: #{File.expand_path(filename)}")

  when OpenAI::Models::ImageGenCompletedEvent
    puts("\n✅ Final image completed!")
    puts("  Size: #{event.b64_json.length} characters (base64)")

    # Save final image to file
    filename = "final_image.png"
    image_data = Base64.decode64(event.b64_json)
    File.write(filename, image_data)
    puts("  Saved to: #{File.expand_path(filename)}")
  end
end

puts "Image streaming completed!"
