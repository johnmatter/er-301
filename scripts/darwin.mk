# Build Tools for OSX

# Use the newest versioned Homebrew GCC (gcc-NN) found on the PATH, since
# Homebrew only installs the current release by default. Override on the
# command line if needed, e.g. make emu GCC_VERSION=11
ifndef GCC_VERSION
  GCC_VERSION := $(shell for d in $$(echo "$$PATH" | tr ':' ' '); do ls "$$d" 2>/dev/null; done | sed -nE 's/^gcc-([0-9]+)$$/\1/p' | sort -n | tail -1)
endif

# Fall back to the previous defaults if no versioned GCC was found:
# gcc-10, or gcc-11 on Apple silicon where no gcc-10 build exists.
ifeq ($(GCC_VERSION),)
  GCC_VERSION = 10
  ifeq ($(shell uname -p),arm)
    GCC_VERSION = 11
  endif
endif

CC := gcc-$(GCC_VERSION) -fdiagnostics-color -fmax-errors=5
CPP := g++-$(GCC_VERSION) -fdiagnostics-color -fmax-errors=5
OBJCOPY := objcopy
OBJDUMP := objdump
ADDR2LINE := addr2line
LD := ld
AR := gcc-ar-$(GCC_VERSION)
SIZE := size
STRIP := strip
READELF := readelf
NM := nm
SWIG := swig
PYTHON := python3
ZIP := zip