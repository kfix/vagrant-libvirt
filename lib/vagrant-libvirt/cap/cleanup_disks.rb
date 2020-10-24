require "log4r"
require "vagrant/util/experimental"

module VagrantPlugins
  module ProviderLibvirt
    module Cap
      class CleanupDisks
        # https://github.com/hashicorp/vagrant/blob/master/plugins/providers/virtualbox/cap/cleanup_disks.rb
        LOGGER = Log4r::Logger.new("vagrant_libvirt::cap::cleanup_disks")

        # @param [Vagrant::Machine] machine
        # @param [VagrantPlugins::Kernel_V2::VagrantConfigDisk] defined_disks
        # @param [Hash] disk_meta_file - A hash of all the previously defined disks from the last configure_disk action
        def self.cleanup_disks(machine, defined_disks, disk_meta_file)
          return if disk_meta_file.values.flatten.empty?
          return if !Vagrant::Util::Experimental.feature_enabled?("disks")

          # Compares the current Vagrant config for defined disks and detaches any disks that are no longer valid for a guest.
          # TOIMPL: reconcile the disk configurations
        end
      end
    end
  end
end
