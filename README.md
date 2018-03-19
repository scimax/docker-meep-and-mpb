# Docker image of MEEP
This repository contains the dockerfile to create the image pymeep hosted at [TODO](). It is originally based on [sirgogos] image but I have replaced everything completely with the [installation instructions](https://www.mail-archive.com/meep-discuss@ab-initio.mit.edu/msg05850.html) provided by Avadan Oskooi.

For more information on MEEP visist the official page at [https://meep.readthedocs.io/en/latest/](https://meep.readthedocs.io/en/latest/)

# Getting the image from docker hub
```sh
docker pull TODO
```

# Run the image in interactive mode
```sh
docker run -it -v C:/path/to/host/directory:/home/hostSRC -v D:/:/home/hostSRC/Simulation-results pymeepimage
```
This will create a new image which you can restart after exiting the container with
```sh
docker start -i <container ID>
```

# Build the image using dockerfile
To build the image place the dockerfile in a directory together with the shell script. Run
```sh
docker build -t pymeepimage .
```

# Other useful commands
```sh
docker ps -a
````
lists all containers, independent from whether they are running or not.
