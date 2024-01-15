# Copyright 2022-2024 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  config,
  lib,
  pkgs,
  ...
}: let
  # Ghaf configuration
  cfg = config.ghaf.systemd.profiles;

  # Systemd profiles
  host_profile = {
    withName = "host-systemd";
    withNss = true;
    withSerial = true;
    withContainers = true;
    withPolkit = true;
    withEfi = pkgs.stdenv.hostPlatform.isEfi;
    withApparmor = true;
    withCryptsetup = true;
    withTpm = true;
  };

  vhost_profile = {
    withName = "vhost-systemd";
    withSerial = config.ghaf.profile.debug.enable;
    withPolkit = true;
    withEfi = pkgs.stdenv.hostPlatform.isEfi;
    withApparmor = true;
    withCryptsetup = true;
    withTpm = true;
  };

  netvm_profile = {
    withName = "netvm-systemd";
    withApparmor = true;
  };

  guivm_profile = {
    withName = "guivm-systemd";
    withApparmor = true;
  };

  appvm_profile = {
    withName = "appvm-systemd";
  };

  cfg_list = [cfg.host.enable cfg.vhost.enable cfg.netvm.enable cfg.guivm.enable cfg.appvm.enable];
in
  with lib; {
    imports = [
      ./base.nix
    ];

    options.ghaf.systemd.profiles.host = {
      enable = mkEnableOption "Enable minimal systemd host configuration profile.";
    };

    options.ghaf.systemd.profiles.vhost = {
      enable = mkEnableOption "Enable minimal systemd host configuration profile.";
    };

    options.ghaf.systemd.profiles.netvm = {
      enable = mkEnableOption "Enable minimal systemd netvm configuration profiles.";
    };

    options.ghaf.systemd.profiles.guivm = {
      enable = mkEnableOption "Enable minimal systemd guivm configuration profiles.";
    };

    options.ghaf.systemd.profiles.appvm = {
      enable = mkEnableOption "Enable minimal systemd appvm configuration profiles.";
    };

    config = {
      assertions = [
        {
          assertion = (lists.count (x: x) cfg_list) == 1;
          message = "One systemd profile can be enabled at a time: " + toString (lists.count (x: x) cfg_list) + " profiles enabled.";
        }
      ];

      ghaf.systemd.base =
        {
          enable = true;
        }
        // (attrsets.optionalAttrs cfg.host.enable host_profile)
        // (attrsets.optionalAttrs cfg.vhost.enable vhost_profile)
        // (attrsets.optionalAttrs cfg.netvm.enable netvm_profile)
        // (attrsets.optionalAttrs cfg.guivm.enable guivm_profile)
        // (attrsets.optionalAttrs cfg.appvm.enable appvm_profile);
    };
  }
