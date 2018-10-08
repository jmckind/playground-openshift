# OpenShift Playground

CentOS 7 VM configured to try out pre-release versions of OpenShift.

## Overview

Included are Vagrant artifacts to provision a VM running CentOS 7 and clone the
configured branch/tag from the OpenShift origin repository to spin up an
all-in-one OpenShift cluster.

## Requirements

The following tools are required to be installed on the host machine.

 * [Vagrant](https://www.vagrantup.com/)
 * [Virtualbox](https://www.virtualbox.org/)

## Usage

Change the `$openshift_version ` variable in the `Vagrantfile` to the desired
branch or tag name from the OpenShift origin
[repository](https://github.com/openshift/origin/branches).

```
$openshift_version = "release-3.11"
```

Provision the new virtual machine. The provisioning process will take some time
to complete and once finished, an all-in-one OpenShift cluster should be
available.

```
vagrant up
```

Once the OpenShift setup is complete, the URL for the cluster should be
displayed in the console. Verify the cluster is operational by visiting the URL
in the browser on the host machine (_see [issue #1](#issues) below_).

```
http://<YOUR CLUSTER IP>.nip.io:8443/console/
```

Once the OpenShift cluster is online and operational, take a snapshot of the VM
to prevent having to do the setup every time a change is made to the cluster.

```
vagrant snapshot save pre-openshift
```

To restore the VM to it's pristine pre-openshift state, simply restore the
snapshot.

```
vagrant snapshot restore --no-provision pre-openshift
```

Clean everything up when the cluster VM is no longer needed.

```
vagrant destroy
```

## Issues

  1. When attempting to log into the web console using the URL for the cluster,
  with no path (i.e `http://<YOUR CLUSTER IP>.nip.io:8443/`), the user is
  redirected to `https://127.0.0.1:8443/console/`, which will not work. This
  appears to be a bug in the `AllowAllPasswordIdentityProvider` when running an
  all-in-one cluster. The work-around is to simply replace the IP address with
  the correct IP for the cluster.

## License

Licensed under the MIT license. See the [LICENSE][license_file] file for
details.

[license_file]:./LICENSE
