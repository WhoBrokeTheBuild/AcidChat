.PHONY: CLIClient clean-CLIClient

CLI_CLIENT_DIR = CLIClient
CLI_CLIENT_OUT = $(BUILD_DIR)/AcidCLI
CLI_CLIENT_SRC = $(shell find $(CLI_CLIENT_DIR)/ -type f -name '*.cpp')
CLI_CLIENT_OBJ = $(addprefix $(OBJ_DIR)/, $(CLI_CLIENT_SRC:.cpp=.o))

NCURSES_CXXFLAGS = $(shell pkg-config --cflags ncurses)
NCURSES_LDFLAGS  = $(shell pkg-config --libs ncurses)

$(OBJ_DIR)/$(CLI_CLIENT_DIR)/%.o: $(CLI_CLIENT_DIR)/%.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(NCURSES_CXXFLAGS) -c -o $@ $<

$(CLI_CLIENT_OUT): $(CLI_CLIENT_OBJ)
	$(LD) -o $(CLI_CLIENT_OUT) $(CLI_CLIENT_OBJ) $(LD_FLAGS) $(NCURSES_LDFLAGS)

CLIClient: $(CLI_CLIENT_OUT)

run-CLIClient:
	cd $(CLI_CLIENT_DIR); ../$(CLI_CLIENT_OUT)

debug-CLIClient:
	cd $(CLI_CLIENT_DIR); gdb ../$(CLI_CLIENT_OUT)

profile-CLIClient:
	cd $(CLI_CLIENT_DIR); valgrind ../$(CLI_CLIENT_OUT)

clean-CLIClient:
	rm -f $(CLI_CLIENT_OBJ) $(CLI_CLIENT_OUT)
