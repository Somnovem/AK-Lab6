ifeq ($(KERNELRELEASE),)
# Regular build environment

KDIR ?= /lib/modules/$(shell uname -r)/build
CROSS_STRIP := $(CROSS_COMPILE)strip

.PHONY: all clean

all:
	$(MAKE) -C $(KDIR) M=$(PWD)
	cp hello.ko hello.ko.unstripped
	$(CROSS_STRIP) -g hello.ko

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean

%.s %.i: %.c
	$(MAKE) -C $(KDIR) M=$(PWD) $@

else
# kbuild part

obj-m := hello.o
ccflags-y += -g

endif