.PHONY: ChatServer clean-ChatServer

SRV_DIR = ChatServer
SRV_OUT = $(BUILD_DIR)/AcidServer
SRV_SRC = $(shell find $(SRV_DIR)/ -type f -name '*.cpp')
SRV_OBJ = $(addprefix $(OBJ_DIR)/, $(SRV_SRC:.cpp=.o))

$(OBJ_DIR)/$(SRV_DIR)/%.o: $(SRV_DIR)/%.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c -o $@ $<

$(SRV_OUT): $(SRV_OBJ)
	$(LD) -o $(SRV_OUT) $(SRV_OBJ) $(LD_FLAGS)

ChatServer: $(SRV_OUT)

run-ChatServer:
	cd $(SRV_DIR); ../$(SRV_OUT)

debug-ChatServer:
	cd $(SRV_DIR); gdb ../$(SRV_OUT)

profile-ChatServer:
	cd $(SRV_DIR); valgrind ../$(SRV_OUT)

clean-ChatServer:
	rm -f $(SRV_OBJ) $(SRV_OUT)
