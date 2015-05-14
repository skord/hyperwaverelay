require "bundler/setup"
require "hyperwaverelay/version"
require "hyperwaverelay/keys"
require "hyperwaverelay/vault"
require "hyperwaverelay/util"
require "thor"

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
      create_file "#{name}/group_vars/all" do
        "---\n"
      end
      template "hyperwaverelay/templates/ansible.cfg.tt", "#{name}/ansible.cfg", {name: name}
      invoke "hyperwaverelay:keys:keygen"
      invoke "hyperwaverelay:vault:gen"
    end
    desc "keys SUBCOMMAND ARGS", "manage SSH keys" 
    subcommand "keys", Keys
    desc "vault SUBCOMMAND ARGS", "manage vault"
    subcommand "vault", Vault
  end
end

