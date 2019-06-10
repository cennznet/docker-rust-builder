FROM rustlang/rust:nightly
COPY llvm.pub /tmp/llvm.pub
RUN  echo 'deb http://apt.llvm.org/stretch/ llvm-toolchain-stretch-8 main' > /etc/apt/sources.list.d/llvm.list && \
	  apt-key add /tmp/llvm.pub && \
	  apt-get update && \
      apt-get -y install apt-utils cmake pkg-config libssl-dev git llvm clang-8 && \
      ln -s /usr/bin/clang-8 /usr/bin/clang && \
      rustup default nightly && \
      rustup target add wasm32-unknown-unknown --toolchain nightly && \
      cargo install --git https://github.com/alexcrichton/wasm-gc && \
      rustup target add x86_64-unknown-linux-musl --toolchain=nightly && \
      rustup component add rustfmt && \
	  apt-get autoremove -y && \
	  apt-get clean && \
      rm /tmp/llvm.pub && \
	  rm -rf /var/lib/apt/lists/*
