#!/bin/sh

# Arg 1 = Reponame
# Arg 2 = Rev number

if [ "$TRAVIS_BRANCH" != "master" ]; then
  exit 1
fi

REPONAME=ladies.codehangar.io
REVISION=${TRAVIS_BUILD_NUMBER}
REV_NAME=${REPONAME}-${REVISION}
echo "REV_NAME:" ${REV_NAME}
echo "TEST_ENV_VAL:" ${TEST_ENV_VAL}
echo "TEST_ENV_VAL2:" ${TEST_ENV_VAL2}
echo "TEST_VAR:" ${TEST_VAR}
echo "TEST_VAR2:" ${TEST_VAR2}

# npm install
# bower install
# gulp clean
# gulp build

# Create tarball
# tar -C dist -cvf artifacts/${REV_NAME}.tar .
tar -C . -cvf ${REV_NAME}.tar .
CMD_RESULT=$?
if [ $CMD_RESULT -ne 0 ]; then
  echo "Tarball Packaging Failed"
  echo $CMD_RESULT
  exit $CMD_RESULT
fi

# Create /var/www directory if not exists
sshpass -e ssh -o StrictHostKeyChecking=no root@datgoat.com "mkdir -p /var/www/${REV_NAME};"
CMD_RESULT=$?
if [ $CMD_RESULT -ne 0 ]; then
  echo "Make remote directory Failed"
  echo $CMD_RESULT
  exit $CMD_RESULT
fi

echo "Transferring Tarball..."
# Transfer tarball
# scp artifacts/${REV_NAME}.tar root@datgoat.com:/var/www/${REV_NAME}.tar
sshpass -e scp -o StrictHostKeyChecking=no ${REV_NAME}.tar root@datgoat.com:/var/www/${REV_NAME}.tar
CMD_RESULT=$?
if [ $CMD_RESULT -ne 0 ]; then
  echo "Tarball Transfer Failed"
  echo $CMD_RESULT
  exit $CMD_RESULT
fi

echo "Unpacking Tarball..."
# Transfer tarball
# Backup current package
# Position new package to be served
# Remove the backup
sshpass -e ssh -o StrictHostKeyChecking=no root@datgoat.com "
  mkdir -p /var/www/${REV_NAME};
  mkdir -p /var/www/${REPONAME};
  tar -xf /var/www/${REV_NAME}.tar -C /var/www/${REV_NAME};
  mv /var/www/${REPONAME} /var/www/${REPONAME}_backup;
  mv /var/www/$REV_NAME /var/www/${REPONAME};
  rm -rf /var/www/${REPONAME}_backup;
"
CMD_RESULT=$?
if [ $CMD_RESULT -ne 0 ]; then
  echo "Unpacking Tarball Failed"
  echo $CMD_RESULT
  exit $CMD_RESULT
fi

exit 0
