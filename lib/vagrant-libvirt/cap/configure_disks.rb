require "log4r"
require "vagrant/util/experimental"

module VagrantPlugins
  module ProviderLibvirt
    module Cap
      class ConfigureDisks
        # https://github.com/hashicorp/vagrant/blob/master/plugins/providers/virtualbox/cap/configure_disks.rb
        LOGGER = Log4r::Logger.new('vagrant_libvirt::cap::configure_disks')

        # @param [Vagrant::Machine] machine
        # @param [VagrantPlugins::Kernel_V2::VagrantConfigDisk] defined_disks
        # @return [Hash] configured_disks - A hash of all the current configured disks
        def self.configure_disks(machine, defined_disks)
          return {} if defined_disks.empty?
          return {} if !Vagrant::Util::Experimental.feature_enabled?("disks")

          # Reads in a Vagrant config for defined disks from a Vagrantfile, and creates and attaches the disks based on the given config

          configured_disks = { disk: [], floppy: [], dvd: [] }

          # FIXME don't reuse the provider_config dsls, make its storage parts more composeable so we can edit them directly
          lvt_config = machine.provider_config

          defined_disks.each do |d|
            if d.type == :dvd
              devnode = lvt_config._get_cdrom_dev(lvt_config.cdroms)
              dvd_data = lvt_config.storage :file, :device => :cdrom, :path => d.file, :dev => devnode
              configured_disks[:dvd] << dvd_data
            else
              # TOIMPL: :disk, :floppy
              machine.ui.info(I18n.t("vagrant.cap.configure_disks.not_supported", name: disk.name))
            end
          end

          configured_disks
        end
      end
    end
  end
end
