require 'thor'
require 'securerandom'

module Hyperwaverelay
  class Vault < Thor
    include Thor::Actions
    desc "gen", "generate vault secrets"
    def gen(root = nil)
      if root
        self.destination_root = File.expand_path(root)
        puts "Entering Project Directory #{File.expand_path(root)}"
      end
      create_file ".vault_password" do
        SecureRandom::base64(20)
      end
    end
    desc "rekey", "rekey encrypted files"
    def rekey
      options[:force] == true
      vaulted_files = Pathname.glob('**/*').select {|f| f.file? && Hyperwaverelay::Util.is_vaulted?(f.to_s)}
      vaulted_files.each do |file|
        puts "Decrypting #{file.to_s}"
        system "ansible-vault decrypt #{file.to_s}"
      end
      invoke :gen, force: true
      vaulted_files.each do |file|
        puts "Recrypting #{file.to_s}"
        system "ansible-vault encrypt #{file.to_s}"
      end
    end
  end
end
