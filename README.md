# playground-openshift

Vagrant artifacts to try out pre-release versions of OpenShift.

## Overview

This project uses Vagrant to provision a virtual machine running CentOS 7 and
installs the configured branch/tag from the OpenShift origin repository.

## Usage

Change the `OPENSHIFT_VERSION` parameter in the `Vagrantfile` to the desired
branch or tag name from the OpenShift origin repository.

```
$openshift_version = "release-3.11"
```

Provision the new virtual machine.

```
vagrant up
```

The provisioning process will take some time to complete and once finished, an
all-in-one openshift cluster should be available.

Once the OpenShift setup is complete, the URL for the cluster should be displayed in the console. Verify the cluster is operational by visiting the URL in the browser on the host machine.

```
http://<YOUR CLUSTER IP>.nip.io:8443/console
```

Once the OpenShift cluster is online and operational, take a snapshot of the VM
to prevent having to do the setup every time a change is made to the cluster.

```
vagrant snapshot push
```

To restore the VM to it's pristine post-setup state, simply restore the
snapshot.

```
vagrant snapshot restore
```

## License

Licensed under the MIT license. See the [LICENSE][license_file] file for
details.

[license_file]:./LICENSE
