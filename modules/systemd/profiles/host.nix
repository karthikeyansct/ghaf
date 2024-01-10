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
        default = true;
      };
    };

    config = mkIf cfg.enable {
      ghaf.systemd.base = {
        enable = true;
        withName = "host-systemd";
        withNss = true;
        withSerial = true;
        inherit (cfg) withContainers;
        withEfi = pkgs.stdenv.hostPlatform.isEfi;
      };
    };
  }
