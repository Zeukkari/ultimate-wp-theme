# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'
require 'yaml'

VAGRANTFILE_API_VERSION ||= "2"
confDir = $confDir ||= File.expand_path("homestead", File.dirname(__FILE__))

homesteadYamlPath = File.expand_path("Homestead.yaml", File.dirname(__FILE__))
homesteadJsonPath = File.expand_path("Homestead.json", File.dirname(__FILE__))
beforeScriptPath = "scripts/vagrant-provision-before.sh"
afterScriptPath = "scripts/vagrant-provision-after.sh"
aliasesPath = "aliases"

require File.expand_path(confDir + '/scripts/homestead.rb')

Vagrant.require_version '>= 2.1.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box_version = "6.3.0"

    config.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--cableconnected1", "on"]
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end

    if File.exist? aliasesPath then
        config.vm.provision "file", source: aliasesPath, destination: "/tmp/bash_aliases"
        config.vm.provision "shell" do |s|
            s.inline = "awk '{ sub(\"\r$\", \"\"); print }' /tmp/bash_aliases > /home/vagrant/.bash_aliases"
        end
    end

    if File.exist? beforeScriptPath then
        config.vm.provision "shell", path: beforeScriptPath, privileged: false
    end

    config.vm.boot_timeout = 300
    if File.exist? homesteadYamlPath then
        settings = YAML::load(File.read(homesteadYamlPath))
    elsif File.exist? homesteadJsonPath then
        settings = JSON.parse(File.read(homesteadJsonPath))
    else
        abort "Homestead settings file not found in #{confDir}"
    end

    Homestead.configure(config, settings)

    if Vagrant.has_plugin?('vagrant-hostsupdater')
        config.hostsupdater.aliases = settings['sites'].map { |site| site['map'] }
    elsif Vagrant.has_plugin?('vagrant-hostmanager')
        config.hostmanager.enabled = true
        config.hostmanager.manage_host = true
        config.hostmanager.aliases = settings['sites'].map { |site| site['map'] }
    end

    if File.exist? afterScriptPath then
        config.vm.provision "shell", path: afterScriptPath, privileged: false
    end
end
