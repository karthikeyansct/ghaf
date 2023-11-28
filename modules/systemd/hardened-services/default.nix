{
	dbus.serviceConfig = (import ./configs/dbus.nix);
	systemd-udevd.serviceConfig = (import ./configs/systemd-udevd.nix);
	ghaf-session.serviceConfig = (import ./configs/ghaf.nix);
	install-microvm-netvm.serviceConfig = (import ./configs/install-microvm.nix);
	nscd.serviceConfig = (import ./configs/nscd.nix);
	audit.serviceConfig = (import ./configs/audit.nix);
	kmod-static-nodes.serviceConfig = (import ./configs/kmod-static-nodes.nix);
	firewall.serviceConfig = (import ./configs/firewall.nix);
	systemd-rfkill.serviceConfig = (import ./configs/systemd-rfkill.nix);
	systemd-random-seed.serviceConfig = (import ./configs/systemd-random-seed.nix);
	systemd-remount-fs.serviceConfig = (import ./configs/systemd-remount-fs.nix);
	systemd-tmpfiles-setup-dev.serviceConfig = (import ./configs/systemd-tmpfiles-setup-dev.nix);
	systemd-tmpfiles-setup.serviceConfig = (import ./configs/systemd-tmpfiles-setup.nix);
	systemd-udev-trigger.serviceConfig = (import ./configs/systemd-udev-trigger.nix);
	systemd-networkd-wait-online.serviceConfig = (import ./configs/systemd-networkd-wait-online.nix);
	generate-shutdown-ramfs.serviceConfig = (import ./configs/generate-shutdown-ramfs.nix);
	network-local-commands.serviceConfig = (import ./configs/network-local-commands.nix);
	systemd-tmpfiles-clean.serviceConfig = (import ./configs/systemd-tmpfiles-clean.nix);
	systemd-user-sessions.serviceConfig = (import ./configs/systemd-user-sessions.nix);
	systemd-fsck-root.serviceConfig = (import ./configs/systemd-fsck-root.nix);
	seatd.serviceConfig = (import ./configs/seatd.nix);
	logrotate-checkconf.serviceConfig = (import ./configs/logrotate-checkconf.nix);
	logrotate.serviceConfig = (import ./configs/logrotate.nix);
	systemd-journal-catalog-update.serviceConfig = (import ./configs/systemd-journal-catalog-update.nix);
	systemd-journal-flush.serviceConfig = (import ./configs/systemd-journal-flush.nix);
	enable-ksm.serviceConfig = (import ./configs/enable-ksm.nix);
	#"user@".serviceConfig = (import ./configs/user.nix);
	"user-runtime-dir@".serviceConfig = (import ./configs/user-runtime-dir.nix);
	"modprobe@".serviceConfig = (import ./configs/modprobe.nix);
	"microvm@".serviceConfig = (import ./configs/microvm.nix);
	"microvm-virtiofsd@".serviceConfig = (import ./configs/microvm-virtiofsd.nix);
	"microvm-tap-interfaces@".serviceConfig = (import ./configs/microvm-tap-interfaces.nix);
}

