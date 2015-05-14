require 'pathname'

module Hyperwaverelay
  class Util
    def self.has_ansible_cfg?
      has_file?('ansible.cfg')
    end
    def self.has_directories?
      has_dir?('group_vars') && has_dir?('host_vars') && has_dir?('roles')
    end
    def self.is_ansible_project?
      has_directories? && has_ansible_cfg?
    end
    def self.vault_present?
      has_hidden_file?('.vault_password')
    end
    def self.is_vaulted?(file)
      File.readlines(file)[0] == "$ANSIBLE_VAULT;1.1;AES256\n"
    end
    protected
    def self.has_file?(filename)
      Pathname.glob('*').any? {|f| f.file? && f.to_s == filename}
    end
    def self.has_dir?(dirname)
      Pathname.glob('*').any? {|d| d.directory? && d.to_s == dirname}
    end
    def self.has_hidden_file?(filename)
      Pathname.glob('.*').any? {|f| f.file? && f.to_s == filename}
    end
  end
end
