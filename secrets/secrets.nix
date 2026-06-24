let
  seyves = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICI9vUBsLuYfgypsDF4UvXIoTn0HDdJRNVt4XKAn6u/L seyves-desktop";

  desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK3TCRWJ4fJUpxnfzmziys1MhWCiPZdvqsp2xzQazK77 root@nixos";
in
{
  "itl-openvpn-ta.age".publicKeys = [
    seyves
    desktop
  ];
  "itl-openvpn-ca.age".publicKeys = [
    seyves
    desktop
  ];
  "itl-openvpn-cert.age".publicKeys = [
    seyves
    desktop
  ];
  "itl-openvpn-key.age".publicKeys = [
    seyves
    desktop
  ];
  "itl-ai-proxy-key.age".publicKeys = [
    seyves
    desktop
  ];
}
