#!/bin/bash
echo "Testing $GITHUB_OWNER/$GITHUB_PROJECT_NAME @ $SHA"
echo "Python version=`python --version`"
echo
# Download and unpack code at the test SHA
echo "curl -L $CODE_URL -o code.zip"
curl -s -L $CODE_URL -o code.zip
echo "--------------------------------------------------------------------------------"
echo "unzip code.zip"
unzip code.zip

echo "--------------------------------------------------------------------------------"
cd $GITHUB_PROJECT_NAME-$SHA
for pkg_dir in $SRC_REQUIRES; do
    echo Installing $pkg_dir from src
    pushd $pkg_dir
    pip install -e .
    popd
done
echo "--------------------------------------------------------------------------------"
if [ -e "$TEST_DIR" ]; then
    cd $TEST_DIR
fi
echo pip install -e .
pip install -e .
echo "================================================================================"
echo python setup.py test
python setup.py test
