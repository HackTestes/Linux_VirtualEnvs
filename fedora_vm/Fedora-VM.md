# Fedora VM settings

It holds the configuration of my Fedora VM

## SSH

* Install
``` bash
sudo dnf install openssh-server
```

* Enable the service
``` bash
sudo systemctl enable --now sshd
```

* Generate key on client (Windows)
    * Press enter to create an empty passphrase or will be prompt it for it on every login
    * Path on Windows: `C:\Users\<user>\.ssh\`
```cmd
ssh-keygen.exe -t rsa
```

* Copy the key to the guest from the client (Windows)
    * Copy the public key on the guest (`\.ssh\id_rsa.pub`)
```cmd
mkdir ~/.ssh && touch ~/.ssh/authorized_keys && nano ~/.ssh/authorized_keys
```

* Disable password login
```
sudo nano /etc/ssh/sshd_config
```

## Other packages

* Install
``` bash
sudo dnf install python pip uv pipx gcc libseccomp libseccomp-devel strace
```

## Important references

* https://linuxconfig.org/how-to-install-start-and-connect-to-ssh-server-on-fedora-linux
* https://www.atlantic.net/vps-hosting/how-to-setup-ssh-key-based-authentication-on-fedora/