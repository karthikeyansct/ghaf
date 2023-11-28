# Copyright 2022-2023 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  config,
  lib,
  pkgs,
  ...
}: let

  # Ghaf configuration
  cfg = config.ghaf.systemd.profiles.vhost;

in
  with lib; {

    imports = [
      ../base.nix
    ];

    options.ghaf.systemd.profiles.vhost = {
      enable = mkOption {
        description = "Enable minimal systemd configuration for the host with virtualization.";
        type = types.bool;
        default = false;
      };

    };

    config = mkIf cfg.enable {
      ghaf.systemd.base = {
        enable = true;
        withName = "vhost-systemd";
        withVirtualization = true;
        withPolkit = true;
        withEfi = pkgs.stdenv.hostPlatform.isEfi;
        withDebug = config.ghaf.profiles.debug.enable;
      };
    };

  }
