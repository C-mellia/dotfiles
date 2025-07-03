#ifndef TEST_UTIL_H
#define TEST_UTIL_H 1

#define testlog(FMT, ...)\
  fprintf(stderr, "%s:%d:%s: "FMT"\n",\
          __FILE__, __LINE__, __func__, ##__VA_ARGS__)

#ifdef panic
#undef panic
#endif // panic

#define panic(FMT, ...) ({\
  testlog(FMT, ##__VA_ARGS__);\
  return -1;\
})

#ifdef assert
#undef assert
#endif // assert

#define assert(cond, FMT, ...) (void)(!!(cond) || ({\
  testlog("Assertion failed: "FMT, ##__VA_ARGS__);\
  return -1; false;\
}))

#ifdef assert_eq
#undef assert_eq
#endif // assert_eq

#ifdef assert_neq
#undef assert_neq
#endif // assert_neq

/*
 * @note: `lhs` and `rhs` needs specific format.
 */
#define assert_eq(lhs, rhs, LHS_FMT, RHS_FMT) \
assert((lhs) == (rhs), "lhs == rhs, lhs: "LHS_FMT", rhs: "RHS_FMT, (lhs), (rhs))
#define assert_neq(lhs, rhs, LHS_FMT, RHS_FMT) \
assert((lhs) != (rhs), "lhs != rhs, lhs: "LHS_FMT", rhs: "RHS_FMT, (lhs), (rhs))

#endif // TEST_UTIL_H
