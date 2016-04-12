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

# npm install
# bower install
# gulp clean
# gulp build

# Create tarball
# tar -C dist -cvf artifacts/${REV_NAME}.tar .
tar -C . -cvf ${REV_NAME}.tar .
if [ $? -ne 0 ]; then
  echo "Tarball Packaging Failed"
  echo $?
  exit $?
fi

# Create /var/www directory if not exists
sshpass -e ssh root@datgoat.com "mkdir -p /var/www/${REV_NAME};"
if [ $? -ne 0 ]; then
  echo "Make remote directory Failed"
  echo $?
  exit $?
fi

echo "Transferring Tarball..."
# Transfer tarball
# scp artifacts/${REV_NAME}.tar root@datgoat.com:/var/www/${REV_NAME}.tar
sshpass -e scp ${REV_NAME}.tar root@datgoat.com:/var/www/${REV_NAME}.tar
if [ $? -ne 0 ]; then
  echo "Tarball Transfer Failed"
  echo $?
  exit $?
fi

echo "Unpacking Tarball..."
# Transfer tarball
# Backup current package
# Position new package to be served
# Remove the backup
sshpass -e ssh root@datgoat.com "
  mkdir -p /var/www/${REV_NAME};
  mkdir -p /var/www/${REPONAME};
  tar -xf /var/www/${REV_NAME}.tar -C /var/www/${REV_NAME};
  mv /var/www/${REPONAME} /var/www/${REPONAME}_backup;
  mv /var/www/$REV_NAME /var/www/${REPONAME};
  rm -rf /var/www/${REPONAME}_backup;
"

echo "Unpacking Tarball Result: " $?
exit $?
