os-tutorial-rs
==============

This is a work-in-progress implementation of a simple operating system in Rust.

It is based on https://github.com/cfenollosa/os-tutorial and is currently implemented through chapter 5.

### bootloader

The bootloader is built with the build script `build.rs`, which uses `nasm` to compile assembly files in `src/boot_sector/`.

You can test the bootloader in `qemu`:
```bash
cargo build
qemu-system-x86_64 $(find target | grep bootloader.bin)
```
