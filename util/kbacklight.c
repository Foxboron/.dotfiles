
/* Author: Howard Chu <hyc@symas.com> 2013-01-15
 * Modified: Morten Linderud <mcfoxax@gmail.com> 2014-06-04
 *
 * monitor keyboard activity and toggle keyboard backlight
 * for Asus laptops. Tested on Asus N56DP.
 */
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <poll.h>
static char dummybuf[8192];
static char newbuf[1];

#ifndef IDLE_MSEC
#define IDLE_MSEC	10000
#endif

int main(int argc, char *argv[])
{
	struct pollfd pfd;
	int rc, blfd, scfd;
	int brt, oldbrt = 3, timeout, prev = -1;
	char bm[2] = "0\n";

	blfd = open("/sys/class/leds/asus::kbd_backlight/brightness", O_RDWR);
	pfd.fd = open("/dev/input/by-path/platform-i8042-serio-0-event-kbd", O_RDONLY);
	pfd.events = POLLIN;

	
    timeout = IDLE_MSEC;
	while (1) {
        rc = poll(&pfd, 1, timeout);

		if (rc) {
			read(pfd.fd, dummybuf, sizeof(dummybuf));
            timeout = IDLE_MSEC;
            brt = oldbrt;
		} else {
			timeout = -1;
            read(blfd, newbuf, 1);
            oldbrt = atoi(newbuf);
			brt = 0;
		}
		if (brt == prev)
			continue;
		bm[0] = brt + '0';
		write(blfd, bm, 2);
		lseek(blfd, 0, SEEK_SET);
		prev = brt;
	}
}
