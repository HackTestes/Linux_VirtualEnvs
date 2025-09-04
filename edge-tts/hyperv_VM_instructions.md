# Edge-tts in a Hyper-V Virtual machine

## General configuration

* Setup the virtual switch to use a pre-defined MAC address: AA-AA-AA-AA-AA-AA (HyperV usually uses 00-15-5d-00-5d-*)
* Connection is done by using the network interface: ssh
* Use a variable for VM name: `$vm = 'Fedora 42'`
* Username: `$user = "caiohvm"`

## Firewall

### Host

Windows Firewall

> [!NOTE]
> Stateful firewalls can see the whole connection lifetime
> So inbound rules can be understood as: all connections that **started** at the **client** (it starts in the host)
> And outbound ones can be: connections that **started** in the **outside world**
> This means that the client can get data from the outside world (outbound direction) if they started the connection (default block inbound)

* The host blocks all connections started by the VM guests (inboud)
    * The goal is to block access to programs that use localhost as IPC (the Steam client for instance)
    * Current setting:
        * all inbound connections of all programs are blocked by default (host <--- outside world) -> can cause VMs to lose internet connectivity
        * Block all connections that have 127.0.0.1 (localhost)

---

WSL

> [!TIP]
> Hyper-V firewall: connection directions are in relationship to the Virtual Machine
> Inbound: VM <--- Outside world
> Outbound: VM ---> Outside world

* Hyper-V firewall is also configured (**WSL only**)
    * See: https://learn.microsoft.com/en-us/windows/security/operating-system-security/network-security/windows-firewall/hyper-v-firewall

    * Default allow outbound: `New-NetFirewallHyperVRule -Name 'HyperVDefaultAllowOutbound' -DisplayName "HyperV - Allow VM outbound by default" -Direction Outbound -Action Allow`

    * Default block inbound connections: `New-NetFirewallHyperVRule -Name 'HyperVDefaultBlockInbound' -DisplayName "HyperV - Block VM inbound by default" -Direction Inbound -Action Block -RulePriority 3`
        * Priority 3: only use this rules if the others don't cover it

    * Allow ssh connections only by the host system: `New-NetFirewallHyperVRule -Name 'HyperVHostOnlySsh' -DisplayName "HyperV - allow ssh only to the host machine" -Direction Inbound -LocalPorts 22 -Action Allow -RemoteAddresses 172.17.0.0-172.31.255.255`

    * Check if everything was set: `Get-NetFirewallHyperVRule`

    * Remove bad rules if necessary: `Remove-NetFirewallHyperVRule -Name 'HyperVDefaultBlockInbound'`

---

> [!TIP]
> Each weight is considered a rule slot. So there can be only one rule per weight per action
> Also, weight is used by the remove command

Regular HyperV VMs

* Hyper-V firewall is also configured (the commands are very similar to the WSL ones)
    * See: https://learn.microsoft.com/en-us/powershell/module/hyper-v/?view=windowsserver2025-ps

    * Allow ssh connections only by the host system:
        * `Add-VMNetworkAdapterExtendedAcl -VMName $vm -Direction Inbound -LocalPort 22 -Action Deny -Weight 2`
        * `Add-VMNetworkAdapterExtendedAcl -VMName $vm -Direction Inbound -LocalPort 22 -Action Allow -RemoteIPAddress 172.17.0.0/12 -Weight 3`
        * `Add-VMNetworkAdapterExtendedAcl -VMName $vm -Direction Outbound -LocalPort 22 -Action Allow -RemoteIPAddress 172.17.0.0/12 -Weight 4`

    * Check if everything was set:
        * `Get-VMNetworkAdapterAcl -VMName $vm`
        * `Get-VMNetworkAdapterExtendedAcl -VMName $vm`

    * Remove all rules if necessary:
        * `Get-VMNetworkAdapterAcl -VMName $vm | Remove-VMNetworkAdapterAcl`
        * `Get-VMNetworkAdapterExtendedAcl -VMName $vm | Remove-VMNetworkAdapterExtendedAcl`

## Filesystem structure

### Host
```
~\Documents
    |
    |---- \Leis
            |
            |---- \Audio
```

### Guest

`~ = /home/$user`

```
~/Dev
    |
    |---- /edge-tts
            |
            |---- /texts
```

## Guest troubleshooting

* Get ssh accesses: `last`
* Get opened ports: `netstat -ntlp`
* Host IP address (it is the same IP address that shows in arp starting with 172.*.*.*): `arp -a`

## Commands

1. Connect SSH to the vm
```
ssh.exe $user@$(arp -a | Select-String -Pattern "00-00-00-00-00-" | %{$_.Line.Split(" ")[2]})
```

1. Copy files to the Virtual Machine (input text)
```
scp.exe .\Documents\Leis\*.txt $user@$(arp -a | Select-String -Pattern "00-00-00-00-00-" | %{$_.Line.Split(" ")[2]}):/home/$user/Dev/edge-tts/texts/
```


1. Copy files back to the host (output audio)
```
scp.exe $user@$(arp -a | Select-String -Pattern "00-00-00-00-00-" | %{$_.Line.Split(" ")[2]}):/home/$user/Dev/edge-tts/texts/*.mp3 .\Documents\Leis\Audio\
```