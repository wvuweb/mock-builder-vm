# A Virtual Machine for Mock Builder

## Introduction

This project automates the setup of a development environment for working with [Mock Builder](https://github.com/wvuweb/mock_builder).

## Installation Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

* [Vagrant Triggers](https://github.com/emyl/vagrant-triggers) Install with: `vagrant plugin install vagrant-triggers`

## How To Build The Mock Builder Virtual Machine

Building the virtual machine is this easy:
```
git clone https://github.com/wvuweb/mock-builder-vm.git
cd mock-builder-vm
vagrant up
```

Make sure that you clone this VM repo into the same directory level as your `slate_themes` folder

Example:
```
/Sites/
 |_/slate_themes/
 |_/mock-builder-vm/
```

When the vagrant process finishes you should be able to access your themes in the browser at [localhost:2000](http://localhost:2000)


## Commands

To be ran from the `/mock-builder-vm/` directory
```
vagrant up              #Start Mock Builder
vagrant halt            #Stop Mock Builder
vagrant mock-update     #Update Mock Builder
```
