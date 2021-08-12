FROM java

ADD ./target/myproject-1.0.0.jar /myproject-1.0.0.jar

EXPOSE 8080:8080

