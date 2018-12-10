require 'config_builder/model'

# Integration with ConfigBuilder 1.x and newer
#
# @since 2.7.0
module VagrantHosts
  module ConfigBuilder
    class Model < ::ConfigBuilder::Model::Provisioner::Base

      # @!attribute [rw] hosts
      def_model_attribute :hosts
      # @!attribute [rw] autoconfigure
      def_model_attribute :autoconfigure
      # @!attribute [rw] add_localhost_hostnames
      def_model_attribute :add_localhost_hostnames
      # @!attribute [rw] sync_hosts
      def_model_attribute :sync_hosts
      # @!attribute [rw] exports
      def_model_attribute :exports
      # @!attribute [rw] exports
      def_model_attribute :imports
      # @!attribute [rw] change_hostname
      def_model_attribute :change_hostname

      # @private
      def configure_exports(config, val)
        val.each do |k, v|
          config.exports[k] ||= []
          config.exports[k] += v
        end
      end

      # @private
      def configure_imports(config, val)
        config.imports += val
        config.imports.uniq!
      end

      # @private
      def configure_hosts(config, val)
        val.each do |(address, aliases)|
          config.add_host(address, aliases)
        end
      end

      ::ConfigBuilder::Model::Provisioner.register('hosts', self)
    end
  end
end
