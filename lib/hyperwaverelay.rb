require "bundler/setup"
require "hyperwaverelay/version"
require "hyperwaverelay/keys"
require "hyperwaverelay/vault"
require "hyperwaverelay/project"
require "hyperwaverelay/util"
require "thor"

class Thor
  def self.source_root
    File.dirname(__FILE__)
  end
end

module Hyperwaverelay
  class Cli < Thor
    include Thor::Actions
    desc "project", "work with your project"
    subcommand "project", Project
    desc "keys SUBCOMMAND ARGS", "manage SSH keys" 
    subcommand "keys", Keys
    desc "vault SUBCOMMAND ARGS", "manage vault"
    subcommand "vault", Vault
  end
end

