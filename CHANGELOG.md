## 2024-01-12

- PCIe support:
  * HardwareInfoLib/HardwareInfoPciHostBridgeLib: Add Segment Group field
  * Ovmf/PlatformPei: Reserve regions defined by the MCFG table

- Shell related changes:
  * ShellPkg: exit the shell if no user interaction for a minute
  * uefi: shell: Disable the shell when UEFI Secure Boot is on
  * bds: Add timeout before reboot

- Security fixes:
  * CVE-2022-36763 - https://github.com/tianocore/edk2/security/advisories/GHSA-xvv8-66cq-prwr
  * CVE-2022-36764 - https://github.com/tianocore/edk2/security/advisories/GHSA-4hcq-p8q8-hj8j
  * CVE-2022-36765 - https://github.com/tianocore/edk2/security/advisories/GHSA-ch4w-v7m3-g8wx

SHA256: 63466debbb4543f8d77254057415b5d2442e42f698fc8ecd06495da264fcfc11

## 2023-05-16

- Enable TPM 2.0 support
- Disable SHA1 measurements for TPM2
- Disable TPM 1.2 support

SHA256: c00148b844a508f82f5a62f0c023857892e9b9723c89907e41f5fe0a9488c633

## 2023-04-21

- Initial support for running x86_64 instances on Nitro
- AMD SEV-SNP support
- MD5: 153de9be3739d5839f5bd851083c9d08
- OVMF hash: a58211791a556a630a4319dc9e2ea96cc0e9784dd9f20a4fadf81b26c98d163fcdcb6703884bbbb80d7b1de45b3d84d0

##
