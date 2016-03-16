.PHONY: all clean

ifndef CXX
CXX = clang++
endif

AR = ar
LD = $(CXX)

BUILD_DIR = Build
OBJ_DIR = $(BUILD_DIR)/obj

CXXFLAGS += -std=c++11 -I include/ -Wall -pedantic -g
LDFLAGS  += -L lib/
LDLIBS   += 

all: ChatServer GTKClient

clean: clean-ChatServer clean-GTKClient

include ChatServer/*.mk
include GTKClient/*.mk
