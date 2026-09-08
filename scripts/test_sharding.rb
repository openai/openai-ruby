# frozen_string_literal: true

module TestSharding
  def self.select(files, shard)
    return files if shard.nil?

    match = /\A([1-9][0-9]*)\/([1-9][0-9]*)\z/.match(shard)
    raise ArgumentError, "TEST_SHARD must be INDEX/COUNT (for example 1/3)" unless match

    index, count = match.captures.map(&:to_i)
    raise ArgumentError, "TEST_SHARD index must not exceed its count" if index > count

    # Keep whole files together: global stubs and large-payload cases retain
    # their existing Minitest::Serial scheduling inside each process.
    files.sort.each_with_index.filter_map { |file, offset| file if offset % count == index - 1 }
  end
end
