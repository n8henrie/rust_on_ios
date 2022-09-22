Built using instructions from <https://github.com/thombles/dw2019rust>

Has a few dependencies (in addition to rustup / rust / cargo)

```console
$ cargo install --force cbindgen
$ rustup target add aarch64-apple-ios-sim
$ rustup target add aarch64-apple-ios
$ rustup target add x86_64-apple-ios
```

I stuck the swift code from the tutorial into `rust_on_iosDocument.swift`.

XCode should be able to build and run the project from scratch, as I added a
build script to compile the rust dependencies.

You should be able to see the `print`ed output in the XCode console.
Additionally, you should be able to see some output generated in Rust on the
opening screen in the iOS Simulator.

## Troubleshooting:

- I made a `Makefile` to for reproducibility, but running `make` from XCode
  uses BSD make (`/usr/bin/make`) instead of GNU make (e.g. via homebrew),
  which results in some issues with the PATH. As a workaround, I set `PATH` in
  the build script (contained within XCode) to use GNU Make and set the path
  for `cargo`.
- I get some odd compilation errors when running the `Makefile` from XCode:
  `ld: library not found for -lSystem` (see also:
  <https://github.com/TimNN/cargo-lipo/issues/41>); exporting `LIBRARY_PATH`
  seems to fix it
