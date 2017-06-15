FROM tomcat:7.0.73-jre8-alpine
LABEL maintainer "chunt"

#args used during building of this image
ARG MY_FILES_DIR=files
ARG TMP_DIR=/root/mytemp
ARG APPDEF_AGENT="AppDefender_Agent"
ARG APPDEF_AGENT_TAR="$APPDEF_AGENT.tar.gz"
ARG TOMCAT_DIR=/usr/local/tomcat

#create temp dir for needed files
RUN mkdir $TMP_DIR/
COPY $MY_FILES_DIR/* $TMP_DIR/

#clear out "default" apps that tomcat includes
#put riches war in webapps dir
#setup for appdefender agent
RUN rm -rf $TOMCAT_DIR/webapps/* && \
	mv $TMP_DIR/riches.war $TOMCAT_DIR/webapps && \
	tar -xvf $TMP_DIR/$APPDEF_AGENT_TAR -C $TOMCAT_DIR/ && \
	mv $APPDEF_AGENT/ AppDefender && \
	mkdir $TOMCAT_DIR/AppDefender/log && \
	sed -i '264i\ #AppDefender Agent installation for Riches' $TOMCAT_DIR/bin/catalina.sh && \
	sed -i '265i \CATALINA_OPTS=" -javaagent:$CATALINA_HOME/AppDefender/lib.latest/FortifyAgent.jar $CATALINA_OPTS"' $TOMCAT_DIR/bin/catalina.sh

#cleanup temp dir
RUN rm -rf $TMP_DIR
