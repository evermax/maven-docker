# Maven in a container

All the credits for this must go to Quinten Krijger for this [post](http://www.infoq.com/articles/docker-executable-images) on infoq.

The purpose of this is to build maven repositories without having maven install on your computer but in a docker container.

## Why?
Well, I guess is goes along with other containers I've been using so far.

First of all, because we can.

Second of all, because then you can have a perfectly viable Java environment... without having Java installed on your computer. And this is quite a plus. It saves up a lot of resources from the computer as the container don't take up all the resource. So of course it is quite slower, but the computer won't end up lagging until maven finished building with Netbeans reindexing everything at the same time, leaving you with no other option but to wait.

Finally, I guess it is easier to set up when someone new comes along, you just have to install docker, give him on file to import in his .profile and ready to go.

## How to run it:

First you need to create a data container. Why? Because otherwise, everytime you are going to run `mvn install` you will have to wait for the dependencies to be downloaded again.
To do so, just type the following:

```
docker run --name maven_data \
    -v /root/.m2 \
    busybox echo 'data for maven'
```

After that, you will have a docker container stopped, with a volume inside that is /root/.m2 and all the other containers that will reference it will have access to it.
If you want to know more about data container, just go on the docker official website, at this [page](https://docs.docker.com/engine/userguide/dockervolumes/).

Then, you should had this function somewhere in your `.profile` or `.bash_profile`, etc.

```
mvn() {
    docker run --rm \
    -v $(pwd):/project \
    --volumes-from maven_data \
    dirichlet/maven $*
}
```

Note that it is important to use the same name that you used creating the data volume container. (If you just copy pasted what I wrote, you should be fine.)
