CC=musl-gcc
CFLAGS=-static -g -pedantic -Wall -Wextra
MAIN_OBJ=ygg.o
OBJS=json-parser/json.o protocol.o
BUILD_OBJS=$(MAIN_OBJ) $(OBJS)
TEST_OBJS=./cutest-1.5/CuTest.o ygg_test.o test.o $(OBJS)

# Normal build
ygg: $(BUILD_OBJS)
	$(CC) $(CFLAGS) $(BUILD_OBJS) -o ygg

protocol.o: protocol.c protocol.h

ygg.o: ygg.c json-parser/json.h

# Dependencies
json.o: json-parser/json.c json-parser/json.h

# Testing
test: ygg-tester
	./ygg-tester

ygg-tester: $(TEST_OBJS)
	$(CC) $(CFLAGS) $(TEST_OBJS) -o ygg-tester

ygg_test.o: ygg_test.c

test.o: test.c

# Test Dependencies
CuTest.o: ./cutest-1.5/CuTest.c ./cutest-1.5/CuTest.h

# Utility targets
clean:
	rm $(OBJS) $(MAIN_OBJ) $(TEST_OBJS) ygg ygg-tester
