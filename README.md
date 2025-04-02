# 66-svmgr-gentoo-overlay
The git repo containing a gentoo overlay for 66 packages... until accepted by Gentoo upstream repo.

`66-dbus-launch` in `sys-apps/66-tools[dbus]` is a replacement to `dbus-broker-launcher` in `sys-apps/dbus-broker[launcher]`. `dbus-broker` is systemd-independent, while the launcher is deeply intertwined into systemd. The 66-dbus-launch uses 66 instead, providing all functions like dbus-activation.
`sys-apps/66-tools[dbus]` on musl with `sys-apps/dbus-broker[-launcher]` and `sys-libs/basu` have some minor issues. The QA-report which is complaining of this isn't descriptive enough. [I just removed dbus-broker from RDEPEND for now...
I have removed the dependency on dbus-broker and added explicit `elog` messages in `pkg_setup` asking users to install as needed.

Basically, the entire package has been masked just because a useflag depends on systemd

Users of this repo, kindly help with those issues... I can be contacted via <pramodvu1502@proton.me>.

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
