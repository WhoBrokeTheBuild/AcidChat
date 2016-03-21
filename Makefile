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

all: ChatServer GTKClient CLIClient

clean: clean-ChatServer clean-GTKClient clean-CLIClient

include ChatServer/*.mk
include CLIClient/*.mk
include GTKClient/*.mk
