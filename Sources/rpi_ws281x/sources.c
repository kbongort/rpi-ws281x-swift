// Conditionally compile the rpi_ws281x sources so that we can still
// write code against the library on a Mac, even if we can't use it.

#ifndef __APPLE__

#include "../../rpi_ws281x/dma.c"
#include "../../rpi_ws281x/mailbox.c"
#include "../../rpi_ws281x/pcm.c"
#include "../../rpi_ws281x/pwm.c"
#include "../../rpi_ws281x/rpihw.c"
#include "../../rpi_ws281x/ws2811.c"

#endif
