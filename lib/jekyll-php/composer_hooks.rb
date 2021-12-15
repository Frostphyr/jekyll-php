module Php
  module ComposerHooks
    require 'open3'

    DEFAULT_FLAGS = %w(
      no-ansi
      no-dev
      no-interaction
      no-plugins
      no-progress
      no-scripts
      optimize-autoloader
    ).freeze

    CONFIG = {
      "environment" => {"type" => String, "default" => "development"},
      "composer" => {"type" => Object, "default" => true},
      "composer_output" => {"type" => Object, "default" => false},
      "composer_command" => {"type" => String, "default" => "composer install"},
      "composer_flags" => {"type" => Array, "default" => DEFAULT_FLAGS}
    }.freeze

    def self.get_config(site, key)
      info = CONFIG[key]
      value = site.config.key?(key) ? site.config[key] : info["default"]
      raise Jekyll::Errors::InvalidConfigurationError,
        "'#{key}' should be set as a(n) #{info["type"]}, but was: #{value.inspect}." unless value.is_a?(info["type"])
      value
    end

    def self.production?(site)
      Jekyll.env == "production" || get_config(site, "environment") == "production"
    end

    def self.composer?(path)
      File.exists?(File.join(path, "composer.json"))
    end

    def self.build_command(site)
      command = get_config(site, "composer_command")
      command << get_config(site, "composer_flags").map {|flag| " --#{flag}"}.join
    end

    Jekyll::Hooks.register :site, :after_init do |site|
      if get_config(site, "composer") == true && composer?(site.source)
        if production?(site)
          site.exclude.push("vendor/")
        else
          site.exclude.push("composer.json", "composer.lock")
        end
      end
    end

    Jekyll::Hooks.register :site, :post_write do |site|
      if get_config(site, "composer") == true && production?(site) && composer?(site.dest)
        output, status = Open3.capture2e(build_command(site), chdir: site.dest)
        File.delete(File.join(site.dest, "composer.json"))
        File.delete(File.join(site.dest, "composer.lock"))
        Jekyll.logger.info(output) if get_config(site, "composer_output") == true
        unless status.success?
          message = "Error installing Composer"
          unless get_config(site, "composer_output") == true
            message.concat("; enable composer_output=true to view the full output")
          end
          raise Jekyll::Errors::FatalException, message
        end
      end
    end
  end
end