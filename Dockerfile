FROM maven:3.8.4-openjdk as maven_builder

ENV HOME=/app

WORKDIR $HOME

ADD . $HOME

#RUN ["/usr/local/bin/mvn-entrypoint.sh", "mvn", "verify", "clean", "--fail-never"]
#ADD . $HOME

RUN ["mvn","clean","package","-DskipTests=true"]

FROM tomcat:8.5.75-jre8-openjdk

#ADD ROOT.xml /usr/local/tomcat/conf/Catalina/localhost/

COPY --from=maven_builder /app/target/redissession.war /usr/local/tomcat/webapps/ROOT.war