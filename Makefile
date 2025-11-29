# ----- PROJECT INFO -----

PROJ_NAME := libcast
PROJ_DESC := "type casting"
PROJ_VER := 1.0

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

.ver: build/lib/libcast.so
	@ver -s -n ${PROJ_NAME} -d ${PROJ_DESC}
	@echo "Updated project metadata"

.__lib__:
	@touch .__lib__
	@echo "Updated library marker file"

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
	uninstall \
	ver

all: build/lib/libcast.so .ver .__lib__
	@echo "Built ${PROJ_NAME} version ${PROJ_VER} (build $$(ver -b))"

clean:
	@rm -rf build
	@echo "All build artifacts removed"

install: build/lib/libcast.so
	@mkdir -p /usr/local/etc/libcast

	@cp cast.h /usr/local/include/cast.h
	@echo "Copied cast.h"
	
	@cp build/lib/libcast.so /usr/local/lib/libcast.so
	@echo "Copied libcast.so"
	
	@cp .ver /usr/local/etc/libcast/.ver
	@echo "Copied .ver"

	@cp .__lib__ /usr/local/etc/libcast/.__lib__
	@echo "Copied .__lib__"

	@echo "${PROJ_NAME} version ${PROJ_VER} successfully installed"

uninstall:
	@rm /usr/local/include/cast.h
	@echo "Deleted cast.h"
	
	@rm /usr/local/lib/libcast.so
	@echo "Deleted libcast.so"
	
	@rm -rf /usr/local/etc/libcast
	@echo "Deleted all configuration files"

	@echo "${PROJ_NAME} successfully uninstalled"

ver:
	@ver -V ${PROJ_VER}
	@echo "Updated version number to ${PROJ_VER}"
