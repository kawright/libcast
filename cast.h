/* Type casting. */

#ifndef CAST_H
#define CAST_H

#include <core.h>
#include <err.h>

/* Convert a string to an I16. */
I16 str_to_i16(Ch *str, U8 base, Err *err);

#endif
