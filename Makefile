CC=gcc

LIBS=sfml-all

CFLAGS=-Wall -Wextra -pedantic `pkgconf --cflags $(LIBS)`
LDFLAGS=-lpthread `pkgconf --libs $(LIBS)`

SRC_DIR=src
HDR_DIR=src 
OBJ_DIR=obj

BIN_DIR=bin
BIN_DEBUG_DIR=$(BIN_DIR)/debug
BIN_RELEASE_DIR=$(BIN_DIR)/release

SRC_FILES=$(wildcard $(SRC_DIR)/**/*.c $(SRC_DIR)/*.c)
OBJ_FILES=$(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))

TARGET=cursed_software

TARGET_DEBUG=$(BIN_DEBUG_DIR)/$(TARGET)_dbg
TARGET_RELEASE=$(BIN_RELEASE_DIR)/$(TARGET)

.PHONY: debug release clean

all: debug release

debug: CFLAGS += -g
debug: $(BIN_DEBUG_DIR) $(OBJ_DIR) $(TARGET_DEBUG)

release: CFLAGS += -O2 -DNDEBUG
release: $(BIN_RELEASE_DIR) $(OBJ_DIR) $(TARGET_RELEASE)

$(TARGET_DEBUG): $(OBJ_FILES) 
	$(CC) $(CFLAGS) $^ -I$(HDR_DIR) -o $@ $(LDFLAGS)

$(TARGET_RELEASE): $(OBJ_FILES)
	$(CC) $(CFLAGS) $^ -I$(HDR_DIR) -o $@ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CC_FLAGS) -c $^ -I$(HDR_DIR) -o $@

$(OBJ_DIR):
	mkdir $@

$(BIN_DEBUG_DIR):
	mkdir -p $@

$(BIN_RELEASE_DIR):
	mkdir -p $@

clean: 
	rm -rf $(OBJ_DIR) $(BIN_DIR)
