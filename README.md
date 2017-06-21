# Application Defender Agent deployed with app
Add AppDefender Agent to your deployed app

Basic setup: deploy container that holds the war's (tomcat or whatever), add the agent and extract it, then modify the startup just as you would from the agent install guide. This was setup so that you put the needed files in a files directory and adding an additional logs directory for the event.gz output from the Agent (basically offloading it from the image to the host so that when you shutdown, you will have them for a syslogger).

# Setup (or fork this repo)
- Dockerfile
- files (directory)
  - AppDefender_Agent.tar.gz
  - riches.war
- appdefender_logs (directory)

# Build
```
docker build --no-cache --tag <image> .
```

# Run 
```
docker run -it -p <external_port>:<internal_port> -v /path/to/appdefender/logs:/usr/local/tomcat/AppDefender/log <image>
```

Known Issues:
- Need to remove contents of [appdefender_logs] directory once image is shutdown (subsequent starts of the same image cant write to these files on restart) FIXME
