# Nitro UEFI

This repository contains the changes that need to be applied on top of
[edk2](https://github.com/tianocore/edk2) in order to run x86_64 guests
on Nitro.  We use [Nix](https://nixos.org/download.html) for creating
reproducible builds of the UEFI binaries to ensure that the same UEFI
binaries that are used with Nitro can be reproduced on any environment.
Nitro customers running AMD SEV-SNP guests can match their running UEFI
firmware with the binaries released here and even reproduce the binaries
themselves.

## How to build

AWS EC2 AMD SEV-SNP enabled instances use UEFI binaries built in this
repository as instance boot firmware. The Github workflow that is run on
every new release uses Nix to build the binary.  However, the binary can
also be generated manually after installing
[Nix](https://nixos.org/download.html) by running the command:

```
nix-build --pure
```

This will produce the `result/ovmf_img.fd` binary which can be matched
against running and released UEFI binaries.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the [BSD-2-Clause-Patent License](LICENSE).

