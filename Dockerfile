FROM java

COPY target/mypapp-0.0.1.jar /mypapp-0.0.1.jar

EXPOSE 8080:8080

ENTRYPOINT ["java","-jar","/mypapp-0.0.1.jar"]