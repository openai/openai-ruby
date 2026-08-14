# frozen_string_literal: true

require "yaml"
require "rubocop"

module RuboCopConfigGuard
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
       .uniq
  end

  def validate(root = ".")
    config_paths(root).flat_map do |path|
      config = RuboCop::ConfigLoader.load_file(File.join(root, path))
      violations_for_config(path, config)
    end
  end
end
