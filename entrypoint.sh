# Setup some text formatting stuff
bold=$(tput bold)
normal=$(tput sgr0)

echo "${bold}STATUS:${normal} Cloning all the repos is required"

# Fetch of all the Github repos if we don't have them already
if [ ! -d "/genny-workspace/genny-main" ]; then
  git clone https://github.com/genny-project/genny-main /genny-workspace/genny-main
fi

if [ ! -d "/genny-workspace/qwanda" ]; then
  git clone https://github.com/genny-project/qwanda /genny-workspace/qwanda
fi

if [ ! -d "/genny-workspace/qwanda-utils" ]; then
git clone https://github.com/genny-project/qwanda-utils /genny-workspace/qwanda-utils
fi

if [ ! -d "/genny-workspace/qwanda-services" ]; then
git clone https://github.com/genny-project/qwanda-services /genny-workspace/qwanda-services
fi

if [ ! -d "/genny-workspace/genny-verticle-rules" ]; then
git clone https://github.com/genny-project/genny-verticle-rules /genny-workspace/genny-verticle-rules
fi

if [ ! -d "/genny-workspace/wildfly-qwanda-service" ]; then
git clone https://github.com/genny-project/wildfly-qwanda-service /genny-workspace/wildfly-qwanda-service
fi

if [ ! -d "/genny-workspace/genny-rules" ]; then
git clone https://github.com/genny-project/genny-rules /genny-workspace/genny-rules
fi

if [ ! -d "/genny-workspace/bridge" ]; then
git clone https://github.com/genny-project/bridge /genny-workspace/bridge
fi

if [ ! -d "/genny-workspace/messages" ]; then
git clone https://github.com/genny-project/messages /genny-workspace/messages
fi

if [ ! -d "/genny-workspace/social" ]; then
git clone https://github.com/genny-project/social /genny-workspace/social
fi

if [ ! -d "/genny-workspace/rulesservice" ]; then
git clone https://github.com/genny-project/rulesservice /genny-workspace/rulesservice
fi

if [ ! -d "/genny-workspace/wildfly-rulesservice" ]; then
git clone https://github.com/genny-project/wildfly-rulesservice /genny-workspace/wildfly-rulesservice
fi

if [ ! -d "/genny-workspace/alyson-v3" ]; then
git clone https://github.com/genny-project/alyson-v3 /genny-workspace/alyson-v3
fi

# Make sure we have the latest copy of everything
echo "${bold}STATUS:${normal} Fetching the latest copy of all the repos"
cd /genny-workspace/genny-main && git pull
cd /genny-workspace/qwanda && git pull
cd /genny-workspace/qwanda-utils && git pull
cd /genny-workspace/qwanda-services && git pull
cd /genny-workspace/genny-verticle-rules && git pull
cd /genny-workspace/wildfly-qwanda-service && git pull
cd /genny-workspace/genny-rules && git pull
cd /genny-workspace/bridge && git pull
cd /genny-workspace/messages && git pull
cd /genny-workspace/social && git pull
cd /genny-workspace/rulesservice && git pull
cd /genny-workspace/wildfly-rulesservice && git pull
cd /genny-workspace/alyson-v3 && git pull

# Now switch to the right versions as specified in the environment
cd /genny-workspace/genny-main && git checkout $GENNY_MAIN_VERSION
cd /genny-workspace/qwanda && git checkout $QWANDA_VERSION
cd /genny-workspace/qwanda-utils && git checkout $QWANDA_UTILS_VERSION
cd /genny-workspace/qwanda-services && git checkout $QWANDA_SERVICES_VERSION
cd /genny-workspace/genny-verticle-rules && git checkout $GENNY_VERTICLE_RULES_VERSION
cd /genny-workspace/bridge && git checkout $BRIDGE_VERSION
cd /genny-workspace/messages && git checkout $MESSAGES_VERSION
cd /genny-workspace/social && git checkout $SOCIAL_VERSION
cd /genny-workspace/rulesservice && git checkout $RULESSERVICE_VERSION
cd /genny-workspace/wildfly-rulesservice && git checkout $WILDFLY_RULESSERVICE_VERSION
cd /genny-workspace/alyson-v3 && git checkout $ALYSON_V3_VERSION

# Let's build everything
if [[ ! -z "$BUILD_JAVA" ]]; then
cd /genny-workspace/qwanda && ./build.sh
cd /genny-workspace/qwanda-utils && ./build.sh
cd /genny-workspace/qwanda-services && ./build.sh
cd /genny-workspace/genny-verticle-rules && ./build.sh
cd /genny-workspace/wildfly-qwanda-service && ./build.sh
cd /genny-workspace/genny-rules && ./build.sh
cd /genny-workspace/bridge && ./build.sh
cd /genny-workspace/messages && ./build.sh
cd /genny-workspace/social && ./build.sh
cd /genny-workspace/rulesservice && ./build.sh
cd /genny-workspace/wildfly-rulesservice && ./build.sh
fi

# Build the Docker images
if [[ ! -z "$BUILD_DOCKER" ]]; then
cd /genny-workspace/wildfly-qwanda-service && ./build-docker.sh
cd /genny-workspace/bridge && ./build-docker.sh
cd /genny-workspace/messages && ./build-docker.sh
cd /genny-workspace/social && ./build-docker.sh
cd /genny-workspace/wildfly-rulesservice && ./build-docker.sh
cd /genny-workspace/alyson-v3 && ./build-docker.sh
fi

# Run the project
if [[ ! -z "$RUN_PROJECT" ]]; then
cp -R /genny-workspace/prj_internmatch /genny-workspace/genny-main
fi