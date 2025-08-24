# Edge-tts in a Hyper-V Virtual machine

## General configuration

* Setup the virtual switch to use a pre-defined MAC address: AA-AA-AA-AA-AA-AA
* Connection is done by using the network interface: ssh

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

`~ = /home/caioh_edgetts`

```
~/Dev
    |
    |---- /edge-tts
            |
            |---- /texts
```

## Commands

1. Connect SSH to the vm
```
ssh.exe caioh_edgetts@$(arp -a | Select-String -Pattern "00-00-00-00-00-" | %{$_.Line.Split(" ")[2]})
```

1. Copy files to the Virtual Machine (input text)
```
scp.exe .\Documents\Leis\*.txt caioh_edgetts@$(arp -a | Select-String -Pattern "00-00-00-00-00-" | %{$_.Line.Split(" ")[2]}):/home/caioh_edgetts/Dev/edge-tts/texts/
```


1. Copy files back to the host (output audio)
```
scp.exe caioh_edgetts@$(arp -a | Select-String -Pattern "00-00-00-00-00-" | %{$_.Line.Split(" ")[2]}):/home/caioh_edgetts/Dev/edge-tts/texts/*.mp3 .\Documents\Leis\Audio\
```