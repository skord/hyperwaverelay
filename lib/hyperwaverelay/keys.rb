require 'thor'
require 'sshkey'

module Hyperwaverelay
  class Keys < Thor
    include Thor::Actions
    desc "keygen key_prefix", "generate ssh keys"
    def keygen(prefix)
      key = ::SSHKey.generate
      create_file "#{ENV['HOME']}/.ssh/#{prefix}_ansible_deploy" do
        key.private_key
      end
      create_file "#{ENV['HOME']}/.ssh/#{prefix}_ansible_deploy.pub" do
        key.ssh_public_key
      end
    end
  end
end
