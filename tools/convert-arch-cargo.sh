# SPDX-FileCopyrightText: 2023 Frederik Zorn <fz@zorrn.net>
#
# SPDX-License-Identifier: Apache-2.0

# convert docker-style target architecture (e.g. linux/arm/v7) to
# cargo-style target architecture (e.g. armv7-unknown-linux-gnueabihf)

# source: https://blog.container-solutions.com/building-multiplatform-container-images

#!/usr/bin/env sh

# merge both variables with a / as seperator if the latter exists
if [ -n "$TARGETVARIANT" ]; then
    TARGET="$TARGETARCH/$TARGETVARIANT"
  else
    TARGET="$TARGETARCH"
fi

# write cargo compatible archs to /.cargo-platform.txt
case $TARGET in

  "amd64")
	  echo "x86_64-unknown-linux-gnu" > /.cargo-platform.txt
    echo "NOTHING=nothing" > /.cargo-linker.txt
    echo "gcc g++" > /.c-compiler.txt
	;;
  "arm64") 
	  echo "aarch64-unknown-linux-gnu" > /.cargo-platform.txt
    echo "CARGO_TARGET_AARCH64_UNKNOWN_LINUX_GNU_LINKER=/usr/bin/aarch64-linux-gnu-gcc" > /.cargo-linker.txt
    echo "gcc-aarch64-linux-gnu g++-aarch64-linux-gnu" > /.c-compiler.txt
	;;
esac
