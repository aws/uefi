{
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/22.11.tar.gz";
    sha256 = "sha256:11w3wn2yjhaa5pv20gbfbirvjq6i3m7pqrq2msf0g7cv44vijwgw";
  }) {}
}:
pkgs.stdenv.mkDerivation rec {
  pname = "nitro-uefi";
  version = "edk2-stable202211";

  nativeBuildInputs = with pkgs; [
    acpica-tools
    git
    libuuid
    nasm
    ncurses
    python3
  ];

  src = pkgs.fetchFromGitHub {
    owner = "tianocore";
    repo = "edk2";
    rev = "edk2-stable202211";
    fetchSubmodules = true;
    sha256 = "sha256-0jE73xPyenAcgJ1mS35oTc5cYw7jJvVYxhPdhTWpKA0=";
  };

  patches = [
    ./edk2-stable202211/0001-edk2-stable202211-nitro-add-build-script.patch
    ./edk2-stable202211/0002-edk2-stable202211-uefi-Set-number-of-queues-upon-controller-initialization.patch
    ./edk2-stable202211/0003-edk2-stable202211-uefi-Apply-e820-reservations-from-fw-cfg.patch
    ./edk2-stable202211/0004-edk2-stable202211-uefi-Add-Amazon-EC2-VGA-device-to-Qemu-video-driver.patch
    ./edk2-stable202211/0005-edk2-stable202211-uefi-bgrt-Change-boot-graphic-ACPI-OemID.patch
    ./edk2-stable202211/0006-edk2-stable202211-efi-x86-Disable-disk-based-non-volatile-variable-store.patch
    ./edk2-stable202211/0007-edk2-stable202211-uefi-Wipe-emulated-NvVariable-memory-on-allocation.patch
    ./edk2-stable202211/0008-edk2-stable202211-uefi-At-least-reserve-0xFFFF-bytes-for-SMBios-tables.patch
    ./edk2-stable202211/0009-edk2-stable202211-uefi-Disable-COM2-in-UEFI-to-prevent-it-from-being-used.patch
    ./edk2-stable202211/0010-edk2-stable202211-uefi-Use-PPI-function-mask-for-user-confirmation.patch
    ./edk2-stable202211/0011-edk2-stable202211-OvmfPkg-Increase-PcdPciMmio64Size-to-16-TiB.patch
    ./edk2-stable202211/0012-edk2-stable202211-nitro-Add-ExtVarStore-for-vmm-based-variable-storage.patch
    ./edk2-stable202211/0013-edk2-stable202211-Varstore-Use-MMIO-access-for-ARM.patch
    ./edk2-stable202211/0014-edk2-stable202211-varstore-Read-feature-flags-from-VMM-over-PIO-MMIO.patch
    ./edk2-stable202211/0015-edk2-stable202211-arm-x86-Enable-Nitro-external-variable-store.patch
    ./edk2-stable202211/0016-edk2-stable202211-x86-Use-simple-emulated-variable-store-instead-of-RAM-persistent.patch
    ./edk2-stable202211/0017-edk2-stable202211-pci-Touch-each-page-when-mapped-for-IO.patch
    ./edk2-stable202211/0018-edk2-stable202211-Image-SecureBoot-Write-the-last-secureboot-status-into-a-variable.patch
    ./edk2-stable202211/0019-edk2-stable202211-BDS-Only-call-the-uefi-shell-as-last-resort.patch
    ./edk2-stable202211/0020-edk2-stable202211-Shell-Report-shelldrop-status-to-the-hypervisor.patch
    ./edk2-stable202211/0021-edk2-stable202211-ExtVarStore-Ensure-spinlock-to-be-in-RuntimeMemory.patch
    ./edk2-stable202211/0022-edk2-stable202211-UEFI-NVMe-Increase-NVMe-generic-timeout-to-5-minutes.patch
    ./edk2-stable202211/0023-edk2-stable202211-ExtVarStore-Add-support-for-PIO-transfer.patch
    ./edk2-stable202211/0024-edk2-stable202211-ExtVarStore-Use-TRANSFER-when-we-run-in-SEV.patch
    ./edk2-stable202211/0025-edk2-stable202211-ExtVarStore-Add-hook-to-force-enable-TRANSFER.patch
  ];

  patchPhase = ''
    # We need a custom patch phase because the default one uses the `patch` utility, which doesn't support binary Git diffs.

    for patchFile in $patches; do
      echo "Patch $patchFile"
      GIT_COMMITTER_NAME=test GIT_COMMITTER_EMAIL=test@localhost git apply "$patchFile"
    done
  '';

  buildPhase = ''
    patchShebangs ./build.sh
    patchShebangs BaseTools/BinWrappers/PosixLike/

    ./build.sh x86
  '';

  installPhase = ''
    mkdir $out
    cp ovmf_img.fd $out/ovmf_img.fd
  '';

  meta = {
    description = "UEFI edk2 for Nitro";
    homepage = https://github.com/aws/uefi;
    license = "bsd";
  };
}
