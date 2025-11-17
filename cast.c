#include "cast.h"

#include <core.h>
#include <err.h>

#include <stdlib.h>

I16 str_to_i16(Ch *str, U8 base, Err *err) {
    Ch      *end;
    I32     ret_data = strtol(str, &end, base);
    if (*end != '\0') {
        THROW(err, ErrCode_DATA, "Invalid integer string %s", str)
        return 0;
    }
    return (I16) ret_data;
}
