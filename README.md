# OpenShift Playground

Vagrant artifacts to try out pre-release versions of OpenShift.

## Overview

This project uses Vagrant to provision a virtual machine running CentOS 7 and
installs the configured branch/tag from the OpenShift origin repository.

## Requirements

The following tools are required to be installed on the host machine.

 * [Vagrant](https://www.vagrantup.com/)
 * [Virtualbox](https://www.virtualbox.org/)

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

Once the OpenShift setup is complete, the URL for the cluster should be
displayed in the console. Verify the cluster is operational by visiting the URL
in the browser on the host machine (_see [issue #1](#issues) below_).

```
http://<YOUR CLUSTER IP>.nip.io:8443/console
```

Once the OpenShift cluster is online and operational, take a snapshot of the VM
to prevent having to do the setup every time a change is made to the cluster.

```
vagrant snapshot save openshift-pre-install
```

To restore the VM to it's pristine post-setup state, simply restore the
snapshot.

```
vagrant snapshot restore --no-provision openshift-pre-install
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
