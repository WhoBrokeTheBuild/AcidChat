.PHONY: GTKClient clean-GTKClient

GTK_CLIENT_DIR = GTKClient
GTK_CLIENT_OUT = $(BUILD_DIR)/AcidGTK
GTK_CLIENT_SRC = $(shell find $(GTK_CLIENT_DIR)/ -type f -name '*.cpp')
GTK_CLIENT_OBJ = $(addprefix $(OBJ_DIR)/, $(GTK_CLIENT_SRC:.cpp=.o))

GTK_CXXFLAGS = $(shell pkg-config gtkmm-3.0 --cflags)
GTK_LDFLAGS = $(shell pkg-config gtkmm-3.0 --libs)

$(OBJ_DIR)/$(GTK_CLIENT_DIR)/%.o: $(GTK_CLIENT_DIR)/%.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) $(GTK_CXXFLAGS) -c -o $@ $<

$(GTK_CLIENT_OUT): $(GTK_CLIENT_OBJ)
	$(LD) -o $(GTK_CLIENT_OUT) $(GTK_CLIENT_OBJ) $(LD_FLAGS) $(GTK_LDFLAGS)

GTKClient: $(GTK_CLIENT_OUT)

run-GTKClient:
	cd $(GTK_CLIENT_DIR); ../$(GTK_CLIENT_OUT)

debug-GTKClient:
	cd $(GTK_CLIENT_DIR); gdb ../$(GTK_CLIENT_OUT)

profile-GTKClient:
	cd $(GTK_CLIENT_DIR); valgrind ../$(GTK_CLIENT_OUT)

clean-GTKClient:
	rm -f $(GTK_CLIENT_OBJ) $(GTK_CLIENT_OUT)
