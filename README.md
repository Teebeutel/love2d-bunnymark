What is Bunnymark?
================

This is the Bunnymark Mk I benchmark for Love2D.

The BunnyMark benchmark is an extremely simple benchmarking script used by a lot of JS graphics engines like PixiJS, EaselJS etc. In this benchmark sprites are simply spawned and moved around the screen. Roughly, the idea is to spawn the maximum possible number of sprites while keeping the fps at 60.

This is basically a port of the script written by the PixiJS guys.

Controls
================
The benchmark runs ten sets of i*10000 bunnies for 1000 frames each and calculates the average framerate, displaying it after each test

After the automatic benchmark is finished, left clicking the mouse anywhere on the screen spawns a litter of bunnies (minimum 1000). The number of generated sprites can be increased or decreased by using the mousewheel.

Credits
================
orginal BunnyMark by to Iain Lobb @ http://blog.iainlobb.com/2010/11/display-list-vs-blitting-results.html

PixiJS Bunnymark by pixiJS @ http://www.goodboydigital.com/pixi-js-bunnymark/

Bunny Image by Amanda Lobb @ http://amandalobb.com/

Initial love2d version by rishavs @ https://github.com/rishavs/love2d-bunnymark
