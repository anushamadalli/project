FROM tomcat:9-jre9
COPY ./target/project.war /usr/local/tomcat/webapps/