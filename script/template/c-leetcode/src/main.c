#include <unistd.h>
#include <fcntl.h>

#include <stdio.h>

#include <garage/input.h>
#include <garage/prelude.h>

#include <solution.h>

static void nest_startup(void);
static void nest_cleanup(void);
static void body(void);

String file = 0;
Array tests = 0;
const char *const input_fname = "input";

int main(void) {
    setup_env("log", 1, 1, nest_startup, nest_cleanup);
    body();
    cleanup();
    return 0;
}

static void nest_startup(void) {
    int fd = open(input_fname, O_RDONLY);
    assert(fd != -1, "Failed to open file: '%s'\n", input_fname);
    file = string_new();
    string_from_file(fd, file), close(fd), fd = -1;
    tests = arr_new(sizeof (Test));
    Slice Cleanup(slice_drop) slice = slice_from_arr((void *)file->arr);
    tests_from_file(slice, tests);
}

static void nest_cleanup(void) {
    for (size_t i = 0; i < tests->_len; ++i) {
        test_drop(arr_get(tests, i));
    }
    string_drop(&file), arr_drop(&tests);
}

static void body(void) {
    for (size_t i = 0; i < tests->_len; ++i) {
        Test test = deref(Test, arr_get(tests, i));
        solution(test);
    }
}
