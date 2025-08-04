.PHONY : window
CC = clang
all : window
export LD_LIBRARY_PATH=/home/juskr/probe/raylib/build/raylib:$LD_LIBRARY_PATH
window : raylib_window.c
	@$(CC) -g -g3 -fsanitize=address,undefined -Wall -Wextra -o window raylib_window.c -lraylib -lGL -lm -lpthread -ldl -lrt -lX11
	@echo ""
	@echo "Program Output : "
	@echo ""
	@./window
clean :
	@rm -f window
	@echo "removed files"
	@sudo rm -rf *.dSYM
