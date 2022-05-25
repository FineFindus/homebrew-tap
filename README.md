# FineFindus's Homebrew Tap
![maintenance-status](https://img.shields.io/badge/maintenance-passively--maintained-yellowgreen.svg)

## About
This tap contains formulaes for finefindus's projects. It currently only includes `artem`.

To add this tap to your brew installation use
```bash
brew tap finefindus/tap
```
It is then possible to install the formulaes from this tap with
```bash
brew install <formula>
```

This tap contains the needed formulae for installing [artem](https://github.com/FineFindus/artem) with `brew`

## Included formulae

### artem
Artem is a small cli program written in rust to easily convert images to ascii art, named after the latin word for art. It will take a while to generate the ascii characters, especially for larger images. By default it tries to use truecolor, if the terminal does not support truecolor, it falls back to 16 Color ANSI. When the ascii image is written to a file, the image will not use colors. It supports .jpeg, .png, .gif, .webp and many more.

To view more information got to it's [project page](https://github.com/FineFindus/artem).

#### Installation
```bash
brew install finefindus/tap/artem
```
#### Updates

Artem will be automatically updated from a [workflow](https://github.com/FineFindus/artem/blob/master/.github/workflows/release_build.yaml), so it 
should theoretically always be up to date with the other releases. There is no guarantee that this will be actually the case, if it hasn't been updated
in a long time, the user is responsible to check if a new version might be available.
