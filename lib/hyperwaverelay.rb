require "bundler/setup"
require "hyperwaverelay/version"
require "securerandom"
require "thor"
require 'sshkey'

module Hyperwaverelay 
  class Cli < Thor
    include Thor::Actions
    def self.source_root
      File.dirname(__FILE__)
    end
    desc "bootstrap project_name", "bootstrap your project"
    option :remote_user
    option :inventory
    option :disable_host_key_checking, type: :boolean
    def bootstrap(name)
      empty_directory(name)
      ["group_vars","host_vars","roles"].each do |dir|
        empty_directory("#{name}/#{dir}")
      end
      create_file "#{name}/.vault_password" do
        SecureRandom::base64(20)
      end
      create_file "#{name}/group_vars/all" do
        "---\n"
      end
      key = ::SSHKey.generate
      create_file "#{ENV['HOME']}/.ssh/ansible_deploy" do
        key.private_key
      end
      create_file "#{ENV['HOME']}/.ssh/ansible_deploy.pub" do
        key.ssh_public_key
      end
      template "hyperwaverelay/templates/ansible.cfg.tt", "#{name}/ansible.cfg"
    end
  end
end

