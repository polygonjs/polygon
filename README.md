This is a rewrite of https://polygonjs.com/ using Jai and WebGPU. The goal is to be able to deploy on the web and desktop, while increasing performance.

This is very early days, and only tested on linux so far.

# Build

## For Desktop

compile: `jai src/jai/build.jai - native`

run: `bin/polygon-next`

## For Web

compile: `jai src/jai/build.jai - wasm`

run: `yarn dev`

# Run test suite

`jai src/jai/build.jai - native test && bin/polygon-next`

