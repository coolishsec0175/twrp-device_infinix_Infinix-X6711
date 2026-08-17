# Android device tree for Infinix X6711 (Infinix-X6711)

OrangeFox Recovery device tree for the Infinix Note 30 5G (X6711).

## Device Specifications

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | Octa-core (2x2.2 GHz Cortex-A76 & 6x2.0 GHz Cortex-A55)
Chipset | MediaTek Dimensity 6080 (MT6833)
GPU     | Mali-G57 MC2
Memory  | 4/8 GB RAM
Shipped Android Version | 13 (XOS 13)
Storage | 128/256 GB (UFS)
Battery | 5000 mAh, non-removable
Display | 1080 x 2460 pixels, 6.78 inches, 120 Hz

## Build

    source build/envsetup.sh
    export FOX_BUILD_TYPE=stable
    lunch twrp_X6711-eng
    mka recoveryimage

## Works

- [X] ADB
- [X] Decryption
- [X] Display
- [X] Fastbootd
- [X] Flashing
- [X] MTP
- [X] Sideload
- [X] USB OTG

## Credits

- [ramabondanp](https://github.com/ramabondanp) - Common Tree for decryption
- [naden01](https://gitlab.com/naden01) - OFOX reference tree (Tecno Pova 5 Pro / LH8n)
