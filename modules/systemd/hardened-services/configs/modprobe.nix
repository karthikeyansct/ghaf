{
  NoNewPrivileges=true;
ProtectClock=true;
ProtectKernelLogs=true;
RestrictNamespaces=true;
Delegate=false;
ProtectProc="noaccess";
UMask=077;
ProtectControlGroups=true;
# ProtectKernelModules=true;
SystemCallArchitectures="native";
MemoryDenyWriteExecute=true;
RestrictSUIDSGID=true;
ProtectHostname=true;
LockPersonality=true;

ProtectKernelTunables=true;
RestrictRealtime=true;
ProtectSystem="full";

# PrivateUsers=true; #RUNS AS ROOT USER
PrivateNetwork=true;
#PrivateTmp=true; #RUNS AS ROOT USER
IPAddressDeny="any";

SystemCallFilter=[
  "~@clock"
  #"~@module"
  "~@raw-io" ##
  #"~@privileged" ##
  "~@cpu-emulation" ##
  "~@debug"
  "~@obsolete"
  "~@swap"
  "~@reboot"
  "~@resources"
  "~@mount"
];

CapabilityBoundingSet=[
  "~CAP_KILL"
  "~CAP_SYS_ADMIN"
  "~CAP_SYS_RAWIO"
  "~CAP_SYS_PTRACE"
  #"~CAP_SYS_MODULE"
  "~CAP_BLOCK_SUSPEND" ##
  "~CAP_LEASE"
  "~CAP_SYS_PACCT"
  "~CAP_LINUX_IMMUTABLE"
  "~CAP_SYS_TTY_CONFIG"
  "~CAP_MKNOD"
  "~CAP_SYS_BOOT"
  "~CAP_SYS_CHROOT"
  "~CAP_NET_ADMIN"
  "~CAP_NET_BIND_SERVICE"
  "~CAP_NET_BROADCAST"
  "~CAP_NET_RAW"
  "~CAP_FOWNER"
];

#RestrictAddressFamilies = [];
RestrictAddressFamilies = ["~AF_PACKET" "~AF_NETLINK" "~AF_UNIX" "~AF_INET" "~AF_INET6"];

}