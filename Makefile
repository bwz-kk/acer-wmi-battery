KDIR := /lib/modules/$(shell uname -r)/build
# Auto-detect a Clang-built kernel (e.g. CachyOS) and build with LLVM=1 in
# that case -- a plain `make` fails on such kernels with
# "unrecognized command-line option" (Clang-specific cflags baked into the
# kernel's own build config). Left empty (plain gcc) on any other kernel.
LLVM := $(shell grep -q '^CONFIG_CC_IS_CLANG=y' $(KDIR)/.config 2>/dev/null && echo 1)

obj-m += acer-wmi-battery.o

all:
	$(MAKE) -C $(KDIR) M=$(CURDIR) LLVM=$(LLVM) modules

clean:
	$(MAKE) -C $(KDIR) M=$(CURDIR) LLVM=$(LLVM) clean
