CC=gcc
SRC= $(wildcard *.c)
OBJ=$(SRC:.c=.o)
FLAG= -W -Wall -Wextra -pedantic -std=c99 
.DEFAULT_GOAL := all

ADDRESS_FLAG=-fsanitize=address \
				 -fno-omit-frame-pointer

THREAD_FLAG=-fsanitize=thread \
				-fno-omit-frame-pointer

UNDEFINED_FLAG = -fsanitize=undefined \
							  -fsanitize=shift \
							  -fsanitize=shift-exponent \
							  -fsanitize=shift-base \
							  -fsanitize=integer-divide-by-zero \
							  -fsanitize=unreachable \
							  -fsanitize=vla-bound \
							  -fsanitize=null \
							  -fsanitize=return \
							  -fsanitize=bounds \
							  -fsanitize=alignment \
							  -fsanitize=object-size \
							  -fsanitize=float-cast-overflow \
							  -fsanitize=nonnull-attribute \
							  -fsanitize=returns-nonnull-attribute \
							  -fsanitize=bool \
							  -fsanitize=enum \
							  -fsanitize=vptr \
							  -fsanitize=pointer-overflow \
							  -fsanitize=builtin \
							  -fsanitize-address-use-after-scope \
							  -fno-omit-frame-pointer \
							  -fstack-protector-strong \
							  -fstack-check

all: main
	@echo "classic"

ifneq (,$(shell find /usr -name "libubsan.so" 2>/dev/null))
UndefinedBehaviour: $(OBJ)
	@$(CC) -o $@ $^ $(UNDEFINED_FLAG)
	@if [ ! -d ./exec ] || [ ! -d ./obj ]; then mkdir exec obj; fi
	@mv $@ exec/
	@mv $(OBJ) obj/
	@echo "UNDEFINED_FLAG"
endif

ifneq (,$(shell find /usr -name "libtsan.so" 2>/dev/null))
Thread: $(OBJ)
	@$(CC) -o $@ $^ $(THREAD_FLAG)
	@if [ ! -d ./exec ] || [ ! -d ./obj ]; then mkdir exec obj; fi
	@mv $@ exec/
	@mv $(OBJ) obj/
	@echo "THREAD_FLAG"
endif

ifneq (,$(shell find /usr -name "libasan.so" 2>/dev/null))
Address: $(OBJ)
	@$(CC) -o $@ $^ $(ADDRESS_FLAG)
	@if [ ! -d ./exec ] || [ ! -d ./obj ]; then mkdir exec obj; fi
	@mv $@ exec/
	@mv $(OBJ) obj/
	@echo "ADDRESS_FLAG"
endif

main: $(OBJ)
	@$(CC) -o $@ $^ $(FLAG)
	@if [ ! -d ./exec ] || [ ! -d ./obj ]; then mkdir exec obj; fi
	@mv $@ exec/
	@mv $(OBJ) obj/


%.o: %.c *.h
	@$(CC) -o $@ -c $< $(FLAG)

clean: 
	@rm -f *.o main
	@if [ -d ./exec ] || [ -d ./obj ]; then rm -r exec obj; fi
