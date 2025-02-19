CC=gcc
CFLAGS=-Wall -Wextra

all: dist/hello

dist/hello: hello.c
	mkdir -p dist
	$(CC) $(CFLAGS) -o dist/hello hello.c

clean:
	rm -rf dist
