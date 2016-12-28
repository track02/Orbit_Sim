# Orbit_Sim

Simple Orbit Simulator written in lua using the LOVE framework.

Basic orbit simulator, allows creation of parent/child components - a child orbits around its parent in the following hierarchy:

Satellite --> Planet --> Solar System --> Galaxy --> Universe (Point)

This effect carries through to the children of children, e.g. a galaxy will orbit the universal point, its children will orbit both the galaxy and the universal point.

![Image_1](https://github.com/track02/Orbit_Sim/blob/master/1.png)
Universe

![Image_2](https://github.com/track02/Orbit_Sim/blob/master/2.png)
Galaxy

![Image_3](https://github.com/track02/Orbit_Sim/blob/master/3.png)
Solar System
