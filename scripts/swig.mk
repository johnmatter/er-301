# SWIG 4.5.0 removed the -no-old-metatable-bindings option (it is now an
# error), so pass it only to older SWIG releases.
SWIG_VERSION := $(shell $(SWIG) -version 2>/dev/null | awk '/SWIG Version/ {print $$3}')
SWIG_LUA_FLAGS := -lua $(shell echo "$(SWIG_VERSION)" | awk -F. '$$1 < 4 || ($$1 == 4 && $$2 < 5) {print "-no-old-metatable-bindings"}')
