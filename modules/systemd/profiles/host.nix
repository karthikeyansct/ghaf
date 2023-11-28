# Copyright 2022-2023 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  config,
  lib,
  pkgs,
  ...
}: let

  # Ghaf configuration
  cfg = config.ghaf.systemd.profiles.host;

in
  with lib; {

    imports = [
      ../base.nix
    ];

    options.ghaf.systemd.profiles.host = {
      enable = mkOption {
        description = "Enable minimal systemd configuration for a host without virtualization.";
        type = types.bool;
        default = false;
      };

       withContainers = mkOption {
        description = "Enable systemd container functionality.";
        type = types.bool;
        default = false;
      };

    };

    config = mkIf cfg.enable {
      ghaf.systemd.base.enable = true;
      ghaf.systemd.base.withName = "host-systemd";
      ghaf.systemd.base.withNss = true;
      ghaf.systemd.base.withSerial = true;
      ghaf.systemd.base.withContainers = cfg.withContainers;
      ghaf.systemd.base.withDebug = config.ghaf.profiles.debug.enable;
    };

  }
