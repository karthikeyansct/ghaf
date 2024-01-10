# Copyright 2022-2023 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  config,
  lib,
  ...
}: let
  # Ghaf configuration
  cfg = config.ghaf.systemd.profiles.appvm;
in
  with lib; {
    imports = [
      ../base.nix
    ];

    options.ghaf.systemd.profiles.appvm = {
      enable = mkOption {
        description = "Enable minimal systemd configuration for app vm.";
        type = types.bool;
        default = false;
      };

      # Container support
      withContainers = mkOption {
        description = "Enable systemd container functionality.";
        type = types.bool;
        default = false;
      };
    };

    config = mkIf cfg.enable {
      ghaf.systemd.base = {
        enable = true;
        withName = "appvm-systemd";
        inherit (cfg) withContainers;
      };
    };
  }
