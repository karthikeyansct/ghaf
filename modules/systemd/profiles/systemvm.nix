# Copyright 2022-2023 TII (SSRC) and the Ghaf contributors
# SPDX-License-Identifier: Apache-2.0
{
  config,
  lib,
  ...
}: let
  # Ghaf configuration
  cfg = config.ghaf.systemd.profiles.systemvm;
in
  with lib; {
    imports = [
      ../base.nix
    ];

    options.ghaf.systemd.profiles.systemvm = {
      enable = mkOption {
        description = "Enable minimal systemd configuration for system vm.";
        type = types.bool;
        default = false;
      };
    };

    config = mkIf cfg.enable {
      ghaf.systemd.base = {
        enable = true;
        withName = "systemvm-systemd";
        withApparmor = true;
      };
    };
  }
