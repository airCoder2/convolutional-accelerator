#include "Utils.h"

namespace ML {



}  // namespace ML
#include <sys/time.h>
#include <xtime_l.h>

extern "C" int _gettimeofday(struct timeval *tv, void *tzvp) {
    if (tv) {
        XTime t;
        XTime_GetTime(&t);
        uint64_t us = (t * 1000000ULL) / COUNTS_PER_SECOND;
        tv->tv_sec = us / 1000000ULL;
        tv->tv_usec = us % 1000000ULL;
    }
    return 0;
}
