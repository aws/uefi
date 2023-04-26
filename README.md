# UEFI

This repository contains the changes that need to be applied on top of
[edk2](https://github.com/tianocore/edk2) in order to run x86_64 guests on
Nitro-based EC2 instances. We use [Nix](https://nixos.org/download.html) for
creating reproducible builds of the UEFI binaries to ensure that the same UEFI
binaries that are used with instance launches can be reproduced on any environment.
EC2 customers running instances with AMD SEV-SNP support can match their
running UEFI firmware with the binaries released here and even reproduce the
binaries themselves.

## How to build

Amazon EC2 instances that have AMD SEV-SNP enabled will use UEFI binaries built
in this repository as instance boot firmware. The Github workflow that is run
on every new release uses Nix to build the binary. However, the binary can also
be generated manually after installing [Nix](https://nixos.org/download.html)
by running the command:

```
nix-build --pure
```

This will produce the `result/ovmf_img.fd` binary which can be matched
against running and released UEFI binaries.

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the [BSD-2-Clause-Patent License](LICENSE).

