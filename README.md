# Gentoo Brother proprietary drivers overlay #

### What is it ###

Gentoo drivers for Brother LPD2500D series.

Printer driver for x86 can be used on amd64 no_multilib system.

### Quick install ###

#### Download proprietary drivers ####

Download deb packages from https://support.brother.com and put it into `/usr/portage/distfiles`

Needed:
- LPR printer driver (dcpl2500dlpr)
- CUPSwrapper printer driver (dcpl2500dcupswrapper)
- Scanner driver (brascan4)

#### Add repository ####

##### Using Layman #####

    layman -o https://github.com/Yakor/y-brother-overlay/overlays.xml -f -a y-brother-overlay

##### Using eselect-repository #####

    eselect repository add y-brother-overlay git https://github.com/yakor/y-brother-overlay.git
    emerge --sync y-brother-overlay

#### Install ####

Scanner driver

    emerge --ask media-gfx/brscan4

Printer driver

    emerge --ask net-print/dcpl2500dcupswrapper
