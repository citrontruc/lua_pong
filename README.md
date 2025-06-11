# Kirball collision test

## Description

A little project to do some tests on collision detection and how to optimize it.

The screen is filled with multiple balls that bounce of off each other. Furthermore, the player controls a square that also has a hitbox.

![Example script running for 500 kirballs](test_kirball.mp4)

## Content

- main script (launch with lua love). Just go in the main directory and type :
```pwsh
love .
```
- ball object to create our balls.
- player object to let our user control the player.
- graphics handler to handle the display of images.
- grid to evaluate collisions by tiles (see optimization paragraph). 


## Optimizations

If we compared all items two by two, we would end up with a complexity of O(n^2) with n the number of balls. In order to avoid that, we divide the screen in a grid of m squares and assign each ball to its tile. We check collisions only with the item of the tile and adjacent tiles, which gives us a complexity of O((n/m)^2).

When loading all the images for our balls, instead of loading our image for each balls, we load the image once and assign it to an ImageItem object which is then consulted by all the Ball objects.
