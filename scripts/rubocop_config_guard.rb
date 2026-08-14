# frozen_string_literal: true

require "json"
require "open3"
require "rbconfig"
require "yaml"

module RuboCopConfigGuard
  ALLOWED_ALL_COPS_EXCLUDES = [
    "bin/*",
    "sorbet/rbi/annotations/**/*",
    "sorbet/rbi/gems/**/*",
    "sorbet/tapioca/**/*"
  ].freeze
  CONFIG_LOADER_MODE = "--load-config"
  DEFAULT_ROOT = File.expand_path("..", __dir__)
  IGNORED_CONFIG_PREFIXES = ["vendor/bundle/"].freeze

  module_function

  def violations_for(path, source)
    config = YAML.safe_load(source, aliases: true) || {}
    return ["#{path}: RuboCop config must be a mapping"] unless config.is_a?(Hash)

    violations_for_config(path, config)
  rescue Psych::Exception => e
    ["#{path}: invalid RuboCop YAML: #{e.message.lines.first.strip}"]
  end

  def violations_for_config(path, config, entrypoint: false, root: DEFAULT_ROOT)
    violations = []
    all_cops = config["AllCops"]
    if all_cops.is_a?(Hash)
      if all_cops["DisabledByDefault"] == true
        violations << "#{path}: AllCops must not set `DisabledByDefault: true`"
      end

      allowed_excludes = ALLOWED_ALL_COPS_EXCLUDES + ALLOWED_ALL_COPS_EXCLUDES.map do |exclude|
        File.join(root, exclude)
      end
      unapproved_excludes = Array(all_cops["Exclude"]) - allowed_excludes
      unless unapproved_excludes.empty?
        violations << "#{path}: AllCops has unapproved `Exclude` paths: #{unapproved_excludes.join(', ')}"
      end

      merged_parameters = Array(config.dig("inherit_mode", "merge"))
      if all_cops.key?("Include") && !merged_parameters.include?("Include")
        violations << "#{path}: AllCops `Include` paths must merge with RuboCop defaults"
      end
    end

    config.each do |name, settings|
      next unless lint_config?(name)
      next unless settings.is_a?(Hash)

      if settings["Enabled"] == false
        violations << "#{path}: #{name} must not set `Enabled: false`"
      end

      if settings.key?("Include")
        violations << "#{path}: #{name} must not define `Include` paths"
      end

      exclude = settings["Exclude"]
      next if exclude.nil? || (exclude.respond_to?(:empty?) && exclude.empty?)

      violations << "#{path}: #{name} must not define `Exclude` paths"
    end

    if entrypoint && (!all_cops.is_a?(Hash) || all_cops["NewCops"] != "enable")
      violations << "#{path}: AllCops must set `NewCops: enable`"
    end
    violations
  end

  def lint_config?(name)
    name == "Lint" || name.start_with?("Lint/")
  end

  def config_paths(root = DEFAULT_ROOT)
    root = File.expand_path(root)
    Dir.glob([".rubocop*.yml", "**/.rubocop*.yml"], base: root, sort: true)
       .select { File.file?(File.join(root, _1)) }
       .reject do |path|
         IGNORED_CONFIG_PREFIXES.any? { |prefix| path.start_with?(prefix) }
       end
       .uniq
  end

  def validate(root = DEFAULT_ROOT)
    root = File.expand_path(root)
    return [".rubocop.yml: root RuboCop config is required"] unless
      File.file?(File.join(root, ".rubocop.yml"))

    config_paths(root)
      .flat_map do |path|
        config = effective_config_for(File.join(root, path))
        violations_for_config(
          path,
          config,
          entrypoint: File.basename(path) == ".rubocop.yml",
          root: root
        )
      end
      .uniq
  end

  def effective_config_for(path)
    stdout, stderr, status = Open3.capture3(
      RbConfig.ruby,
      File.expand_path(__FILE__),
      CONFIG_LOADER_MODE,
      path,
      chdir: DEFAULT_ROOT
    )
    warn(stderr) unless stderr.empty?
    raise "Failed to load RuboCop configuration #{path}" unless status.success?

    JSON.parse(stdout)
  end
end

if $PROGRAM_NAME == __FILE__
  abort("Usage: #{__FILE__} #{RuboCopConfigGuard::CONFIG_LOADER_MODE} PATH") unless
    ARGV.shift == RuboCopConfigGuard::CONFIG_LOADER_MODE

  require "rubocop"

  output = $stdout
  begin
    $stdout = $stderr
    config = RuboCop::ConfigLoader.load_file(ARGV.fetch(0))
  ensure
    $stdout = output
  end
  output.write(JSON.generate(config.to_h))
end
