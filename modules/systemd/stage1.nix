# Copyright 2022-2023 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  config,
  lib,
  pkgs,
  ...
}: let
  # Ghaf configuration flag
  cfg = config.ghaf.systemd.stage1;
  cfgDebug = config.ghaf.profiles.debug.enable;

  # Override minimal with stage1 configuration set
  packageConfiguration = pkgs.systemdMinimal.override {
    pname = "stage1-systemd";
    withAcl = true;
    withCompression = cfgDebug;
    withCoredump = cfgDebug;
    inherit (cfg) withCryptsetup;
    withEfi = pkgs.stdenv.hostPlatform.isEfi;
    withFido2 = cfg.withFido;
    withKexectools = false;
    withKmod = true;
    withLibseccomp = false;
    withSelinux = false;
    withTpm2Tss = cfg.withTpm;
    withUtmp = false;
  };

  # Excluded systemd units for initrd
  unitConfiguration =
    [
      # Excluded Targets
      "paths.target"
      "slices.target"
      "sockets.target"
      "halt.target"
      "local-fs-pre.target"
      "local-fs.target"
      "reboot.target"
      "rescue.target"
      "shutdown.target"
      "multi-user.target"
      "ctrl-alt-del.target"
      "timers.target"
      "kexec.target"

      # Excluded Services
      "kmod-static-nodes.service"
      "sys-kernel-config.mount"
      "systemd-modules-load.service"
      "systemd-halt.service"
      "sigpwr.target"
      "rescue.service"
      "systemd-journald.service"
      "systemd-poweroff.service"
      "systemd-reboot.service"
      "systemd-sysctl.service"
      "systemd-ask-password-console.service"
      "systemd-ask-password-console.path"
      "systemd-fsck@.service"
      "systemd-hibernate-resume@.service"
      "systemd-tmpfiles-setup-dev.service"
      "systemd-tmpfiles-setup.service"
      "systemd-kexec.service"
    ]
    ++ (lib.optionals (!cfgDebug) [
      "emergency.service"
      "emergency.target"
      "syslog.socket"
      "systemd-journald-audit.socket"
      "systemd-journald-dev-log.socket"
      "systemd-journald.socket"
    ]);
in
  with lib; {
    options.ghaf.systemd.stage1 = {
      # Minimal stage1-systemd is disabled by default
      enable = mkOption {
        description = "Enable systemd in stage 1 of the boot (initrd).";
        type = types.bool;
        default = false;
      };

      # Cryptsetup utility
      withCryptsetup = mkOption {
        description = "Enable LUKS2 functionality.";
        type = types.bool;
        default = false;
      };

      # Fido2 token support
      withFido = mkOption {
        description = "Enable Fido2 token functionality.";
        type = types.bool;
        default = false;
      };

      # TPM2 software stack
      withTpm = mkOption {
        description = "Enable TPM functionality.";
        type = types.bool;
        default = false;
      };
    };

    config = mkIf cfg.enable {
      # Enable systemd in initrd
      boot.initrd.systemd = {
        enable = true;
        emergencyAccess = cfgDebug;
        suppressedUnits = unitConfiguration;
        package = packageConfiguration;
      };
    };
  }
