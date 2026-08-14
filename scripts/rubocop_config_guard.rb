# frozen_string_literal: true

require "yaml"
require "pathname"

module RuboCopConfigGuard
  IGNORED_CONFIG_PREFIXES = ["vendor/bundle/"].freeze

  module_function

  def violations_for(path, source)
    config = YAML.safe_load(source, aliases: true) || {}
    return ["#{path}: RuboCop config must be a mapping"] unless config.is_a?(Hash)

    violations_for_config(path, config)
  rescue Psych::Exception => e
    ["#{path}: invalid RuboCop YAML: #{e.message.lines.first.strip}"]
  end

  def violations_for_config(path, config)
    violations = []
    config.each do |name, settings|
      next unless lint_config?(name)
      next unless settings.is_a?(Hash)

      if settings["Enabled"] == false
        violations << "#{path}: #{name} must not set `Enabled: false`"
      end

      exclude = settings["Exclude"]
      next if exclude.nil? || (exclude.respond_to?(:empty?) && exclude.empty?)

      violations << "#{path}: #{name} must not define `Exclude` paths"
    end
    violations
  end

  def lint_config?(name)
    name == "Lint" || name.start_with?("Lint/")
  end

  def config_paths(root = ".")
    root = File.expand_path(root)
    Dir.glob([".rubocop*.yml", "**/.rubocop*.yml"], base: root, sort: true)
       .select { File.file?(File.join(root, _1)) }
       .reject do |path|
         IGNORED_CONFIG_PREFIXES.any? { |prefix| path.start_with?(prefix) }
       end
       .uniq
  end

  def validate(root = ".")
    root = File.expand_path(root)
    visited = Set.new
    config_paths(root).flat_map { validate_path(root, _1, visited) }.uniq
  end

  def validate_path(root, path, visited)
    absolute_path = File.expand_path(path, root)
    return [] if visited.include?(absolute_path)

    visited << absolute_path
    source = File.read(absolute_path)
    config = YAML.safe_load(source, aliases: true) || {}
    relative_path = Pathname(absolute_path).relative_path_from(Pathname(root)).to_s
    return ["#{relative_path}: RuboCop config must be a mapping"] unless config.is_a?(Hash)

    inherited = Array(config["inherit_from"]).flat_map do |entry|
      next [] unless entry.is_a?(String)
      next [] if entry.start_with?("http://", "https://")

      Dir.glob(File.expand_path(entry, File.dirname(absolute_path))).select { File.file?(_1) }
    end

    violations_for_config(relative_path, config) +
      inherited.flat_map { validate_path(root, _1, visited) }
  rescue Psych::Exception => e
    ["#{path}: invalid RuboCop YAML: #{e.message.lines.first.strip}"]
  end
end
