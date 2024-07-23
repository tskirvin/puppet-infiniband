# Fact: infiniband_fw_versions
#
# Purpose: Report the version of all InfiniBand hardware
#
# Resolution:
#   Returns InfiniBand device FW Versions
#

require 'facter/util/infiniband'

Facter.add(:infiniband_fw_versions) do
  confine has_infiniband: true
  ports = Facter::Util::Infiniband.ports
  setcode do
    versions = {}
    ports.each do |port|
      fw_version = Facter::Util::Infiniband.get_port_fw_version(port)
      if fw_version
        versions[port] = fw_version
      end
    end
  
    if versions.empty?
      nil
    else
      versions
    end
  end
end
