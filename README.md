# appdefender
riches web application with AppDefender Agent

uses tomcat:7.0.73-jre8-alpine docker image as the base

runs Riches war with AppDefender Agent

There are files needed (license agreement with HPE Security Fortify required) and small amounts of setup required in order to use the Dockerfile for this image.

VM setup where running docker from:
- Dockerfile
- files (directory)
  - AppDefender_Agent.tar.gz
  - riches.war
- appdefender_logs (directory)



Build Image
```
docker build --tag [image] .
```

Run Image 
```
docker run -it -p [external_port]:8080 -v [path_to_appdefender_logs]:/usr/local/tomcat/AppDefender/log [image]
```

Known Issues:
- Need to remove contents of [appdefender_logs] directory once image is shutdown (subsequent starts of the same image cant write to these files on restart)
