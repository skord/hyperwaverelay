require 'thor'

module Hyperwaverelay
  class Project < Thor
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
      template "templates/ansible.cfg.tt", "#{name}/ansible.cfg", {name: name}
      invoke "hyperwaverelay:keys:keygen"
      invoke "hyperwaverelay:vault:gen"
    end
  end
end
