FROM rustlang/rust:nightly
RUN apt-get update && \
      apt-get -y install apt-utils cmake pkg-config libssl-dev git clang libclang-dev llvm && \
      rustup default nightly && \
      rustup target add wasm32-unknown-unknown --toolchain nightly && \
      cargo install --git https://github.com/alexcrichton/wasm-gc && \
      rustup target add x86_64-unknown-linux-musl --toolchain=nightly && \
      rustup component add rustfmt
