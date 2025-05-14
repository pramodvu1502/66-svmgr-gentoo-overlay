# 66-svmgr-gentoo-overlay
The git repo containing a gentoo overlay for 66 packages... until accepted by Gentoo upstream repo.

# Adding the overlay on your system
Provided that `app-eselect/eselect-repository` is installed (It *will* be on 99% systems), this will work for most users.
`eselect repository add 66-svmgr git https://github.com/pramodvu1502/66-svmgr-gentoo-overlay.git`

To manually add the overlay, create a file `/etc/portage/repos.conf/66-svmgr.conf` with:
```
[66-svmgr]
location = /var/db/repos/66-svmgr
sync-type = git
sync-uri = https://github.com/pramodvu1502/66-svmgr-gentoo-overlay.git
```

After adding the overlay by either method, run `emerge --sync 66-svmgr` or `emaint sync -r 66-svmgr` to sync the repo to your system.

# Packages included:
- `sys-apps/66` is the core set of binaries which forms the service management toolset.
- `sys-apps/66-tools` is a collection of helper tools which complete the 66 suite, providig conveniences.
- `sys-libs/oblibs` is a small general-puspose convenience library used by all 66 software.
- `sys-apps/turnstile` is a simple (incomplete as of now) session management daemon aimed at replacing (e)logind but alongside seatd and acpid.
- `sys-process/66-boot` is the "boot"/"init" module needed for booting into a stupidly simple system to the tty.
- [TBD] `sys-process/66-initial-setup` is 66's equivalent of a "firstboot"; 66 doesn't have the concept of a "firstboot".
- `sys-apps/sdnotify-wrapper` is a wrapper allowing a daemon to use s6's notification protocol, but relaying it to `sd_notify()`.
- `66-frontend` is a new category in this repository, for ebuilds supplying service frontends.
- `66-frontend/66-service-meta` is a useflag-configured metapackage to pull the packages supplying frontends. It is meant to be used instead of cluttering the portage world file.
- All other packages in `66-frontend` category aren't documented here, they just supply a file or two, service definiton frontends for 66.

# Some miscellaneous relevant info:
- Testers will be appreciated
- `sys-process/66-initial-setup` needs some thought on what exactly to do...
