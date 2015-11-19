FROM maven:3.3.3-jdk-8

MAINTAINER Maxime Lasserre "maxlasserre@free.fr"

WORKDIR /project
ENTRYPOINT ["mvn"]
CMD ["-h"]
