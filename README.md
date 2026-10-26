# MTASC

A maintained fork of **MTASC** (Motion-Twin ActionScript Compiler), the open source
ActionScript 2 compiler, updated to build and run on modern operating systems.

MTASC hasn't had a release since 2009, and the old builds no longer run on current
systems. This fork fixes that, so you can compile AS2 to SWF today: for Ruffle,
Flash preservation, modding, or maintaining legacy projects.

## Install

- **Prebuilt binaries:** download from [Releases](https://github.com/markhughes/mtasc/releases)
- **From source:** see [Building](#building)

## Usage

    mtasc -cp std -swf out.swf -header 800:600:30 -main Main.as

## Building

    git clone --recursive https://github.com/markhughes/mtasc
    cd mtasc
    ./build.sh

## Changes since 1.15

- Builds and runs on modern operating systems

## History & credits

MTASC was written by Nicolas Cannasse at Motion-Twin and was the precursor to
[Haxe](https://haxe.org). Motion-Twin's last release was 1.14. Development continued
in the [MTASC Community Fork](https://sourceforge.net/projects/mtasc/) on SourceForge,
which last released in 2009.

This fork also builds on the community work in
[grumpy-cat-whatever/mtasc](https://github.com/grumpy-cat-whatever/mtasc) and
[mtasc-install](https://github.com/grumpy-cat-whatever/mtasc-install).

## License

GPL-2.0. See [LICENSE](LICENSE).
