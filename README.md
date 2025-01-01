# Development Linux virtual environments

This is a personal repository containing documentation on how I setup development environments for each of my projects in Linux. The goal is to help me maintain the necessary steps and configurations in a backup.

## Sharing

* Goal: share host dependencies with the environments to avoid
    * having multiple copies (disk space saving)
    * having to update multiple containers
    * protect the executables against writes
    
* DO NOT share /home! It is better to create a new home or tmpfs it.

### /dev

* Dangerous, only share when necessary! Exceptions could be sharing the GPU or /dev/null.

### /run

* Also dangerous as it contains sockets to dbus, wayland display and various portals. Only share when necessary.

## Security

* Goal: keep all of the project isolated from the host, hiding my home directory, but still sharing host binaries.

### AppArmor

* "&" is used to indicate that a profile transition with no_new_privs bit set is possible, in other words, the next profile has less privileges than the first. If it isn't used, all profile transitions are denied.

* The profile uses the current root file to apply rules, therefore bind mount can bypass any rule if allowed. This is also important for containers as the rules needs to relative to them.

* attach_disconnected and userns are needed to allow containers to create namespaces

### Bubblewrap (bwrap)

* It creates a tmpfs at the container's root (/)

* Is always set the no_new_privs

### SECCOMP

* Please refer to Android's default SECCOMP profile for a good starting point
    * Doc: https://android-developers.googleblog.com/2017/07/seccomp-filter-in-android-o.html
    * Syscall list: https://android.googlesource.com/platform/bionic/+/refs/heads/main/libc/SYSCALLS.TXT
    * Other lists at libc (SECCOMP_*.TXT): https://android.googlesource.com/platform/bionic/+/refs/heads/main/libc
    
### Landlock

* Setprivs is a good start

### Dbus

* An IPC bus and can allow apps to start apps OUTSIDE of the container. It is best to control it.

* It is currently sandboxed by AppArmor profiles
