FROM openjdk:11
WORKDIR /BUILDS
COPY C:\\Users\\pavan\\OneDrive\\Desktop\\DevOps\\Jenkins\\Builds\\addressbook.war addressbook.war
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "addressbook.war", "--server.port=8081"]
