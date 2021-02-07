# Oracle 19c on Red Hat Linux 8

A simple Vagrant build for Oracle Database 19c on Red hat linux 8.

**Note:** the vagrant base box of RHEL8 is generic will be provisioned with the prerequisite rpm packages for Oracle 19c from a RHEL8 beta repository during vagrant start(see install_os_packages.sh for details).
      
Only the database will be installed and all other application creation scripts have been commented out(ords,sqlc etc).
oracle-database-preinstall-19c package required two external packages to be installed (see install_os_packages.sh for details).
     
Enjoy

## Required Software

* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Oracle Database](https://www.oracle.com/technetwork/database/enterprise-edition/downloads/oracle19c-linux-5462157.html)

Place the software in the "software" directory before calling the `vagrant up` command.

Directory contents when software is included.

```
$ tree
.
+--- README.md
+--- scripts
|   +--- dbora.service
|   +--- install_os_packages.sh
|   +--- oracle_create_database.sh
|   +--- oracle_service_setup.sh
|   +--- oracle_software_installation.sh
|   +--- oracle_user_environment_setup.sh
|   +--- prepare_u01_u02_disks.sh
|   +--- root_setup.sh
|   +--- setup.sh
+--- software
|   +--- LINUX.X64_193000_db_home.zip
|   +--- put_software_here.txt        
+--- Vagrantfile
$
```
