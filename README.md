# docker

## 1. sage notebook

__[SageMath](http://www.sagemath.org)__ is a free open-source mathematics software system licensed under the GPL. It builds on top of many existing open-source packages: NumPy, SciPy, matplotlib, Sympy, Maxima, GAP, FLINT, R and many more. Access their combined power through a common, Python-based language or directly via interfaces or wrappers.
Mission: Creating a viable free open source alternative to Magma, Maple, Mathematica and Matlab.

## Use this image exposing the port
This image is configured with a volume at /home/sage/notebook_data.sagenb to hold the persisted index data.

        docker run -it -p 8080:8080 -v /Users/sage/docker/mount/sage/notebook_data.sagenb:/home/sage/notebook_data.sagenb dieudonne/sage

then in the container, run the command

        #sage: notebook(directory="/home/sage/notebook_data", interface="0.0.0.0",automatic_login=False)
Then you can hit http://localhost:8080 or http://host-ip:8080 in your browser.
