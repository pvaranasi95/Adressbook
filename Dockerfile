FROM tomcat:9.0-jdk17

# Clean default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR into Tomcat
COPY addressbook.war /usr/local/tomcat/webapps/addressbook.war

EXPOSE 8081
