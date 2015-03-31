# A Virtual Machine for Mock Builder

## Introduction

This project automates the setup of a development environment for working with [Mock Builder](https://github.com/wvuweb/mock_builder).

## How to install

  1. Install [VirtualBox](https://www.virtualbox.org)
    * Install v4.3.24 or greater.
  1. Install [Vagrant](http://vagrantup.com)
    * Install v1.7.2 or greater.
  1. Install [Vagrant Triggers](https://github.com/emyl/vagrant-triggers) by running:
    * `vagrant plugin install vagrant-triggers`
  1. If you dont have the `Sites` and `slate_themes` folders, run the following otherwise skip this step:
    * `cd ~ && mkdir Sites && cd ~/Sites/ && mkdir slate_themes`
  1. Next we have to build the Mock Builder virtual machine. Building the virtual machine is easy:
    ```bash
    cd ~/Sites/ && git clone https://github.com/wvuweb/mock-builder-vm.git
    cd mock-builder-vm
    vagrant up
    ```

    * **NOTE:** The first time you run `vagrant up`, it may take 5-30 minutes to build the virtual machine. On subsequent `vagrant up`'s it will only take a few seconds.
  1. Visit [localhost:2000](http://localhost:2000) in the browser at to access your [Slate](http://slatecms.wvu.edu) themes.

If the build fails run `vagrant provision` until it completes.  If you have continue to have issues, open an [issue](https://github.com/wvuweb/mock-builder-vm/issues).

## Commands

To be ran from the `/mock-builder-vm/` directory
```bash
vagrant up              # Start Mock Builder
vagrant halt            # Stop Mock Builder
vagrant mock update   # Update Mock Builder
vagrant status          # Is the VM running?
```

## Mac/Linux Alias

If you would like to have aliases for the above command add the following to your `.bash_profile`, `.bashrc`, or `.profile` in your user root directory.
```
alias mock-start="cd ~/Sites/mock-builder-vm && vagrant up"
alias mock-stop="cd ~/Sites/mock-builder-vm && vagrant halt"
alias mock-update="cd ~/Sites/mock-builder-vm && vagrant mock update"
```

### Other Notes

Truth be told, you don't actually need a `Sites` folder—we simply include it for consistency. To get Mock Builder working, the `mock-builder-vm` and `slate_themes` directories must be on the same level, like so:
```
/Sites/
|_/mock-builder-vm/
|_/slate_themes/
```
