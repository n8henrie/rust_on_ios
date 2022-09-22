.PHONY: debug
debug: target/aarch64-apple-ios-sim/debug/librustyios.a target/rustyios.h
	cp "$<" target/librustyios.a

.PHONY: release
release: clean target/rustyios.h target/librustyios.a

target/x86_64-apple-ios/debug/librustyios.a: src/lib.rs
	cargo build --release --target x86_64-apple-ios

target/aarch64-apple-ios/debug/librustyios.a: src/lib.rs
	cargo build --release --target aarch64-apple-ios

target/aarch64-apple-ios-sim/debug/librustyios.a: src/lib.rs
	cargo build --target aarch64-apple-ios-sim

target/librustyios.a: target/aarch64-apple-ios-sim/debug/librustyios.a target/aarch64-apple-ios/debug/librustyios.a target/x86_64-apple-ios/debug/librustyios.a
	lipo -create $^ -output $@

target/rustyios.h: src/lib.rs
	cbindgen --lang C --output $@

.PHONY: clean
clean:
	cargo clean
