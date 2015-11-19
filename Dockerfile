FROM maven:3.3.3-jdk-8
WORKDIR /project
ENTRYPOINT ["mvn"]
CMD ["-h"]
