# ----- PROJECT INFO -----

PROJ_NAME := libcast
VER := 1.0

# ----- COMPILER CONFIGURATION -----

CC := gcc
CC_OPTS := \
	-Wall \
	-Werror \
	-fpic \
	-g

CC_LIBS := \
	-lerr

# ----- REAL TARGETS -----

build/lib/libcast.so: build/obj/cast.o
	@mkdir -p build/lib
	@${CC} -shared -o $@ $< ${CC_LIBS}
	@echo "Built target $@"

build/obj/cast.o: cast.c cast.h Makefile
	@mkdir -p build/obj
	@${CC} ${CC_OPTS} -c -o $@ $<
	@echo "Built target $@"

# ----- PHONY TARGETS -----

.PHONY: \
	all \
	clean \
	install \
	uninstall

all: build/lib/libcast.so
	@echo Built ${PROJ_NAME} version ${VER}

clean:
	@rm -rf build
	@echo "All build artifacts removed"

install: build/lib/libcast.so
	@cp cast.h /usr/local/include/cast.h
	@echo "Copied cast.h"
	@cp build/lib/libcast.so /usr/local/lib/libcast.so
	@echo "Copied libcast.so"
	@echo "${PROJ_NAME} version ${VER} successfully installed"

uninstall:
	@rm /usr/local/include/cast.h
	@echo "Deleted cast.h"
	@rm /usr/local/lib/libcast.so
	@echo "Deleted libcast.so"
	@echo "${PROJ_NAME} successfully uninstalled"

