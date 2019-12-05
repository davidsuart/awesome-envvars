#!/usr/bin/env sh

echo "---------- Testing secrets manager json input ----------"
echo ""

# fetch the contents of our ENV environment variable
echo "Show the received input value in \$ENV:"
echo " \$ENV = $ENV"
echo ""

echo "Show that our target env vars are empty:"
echo "  \$ENV_TEST_ONE     = $ENV_TEST_ONE"
echo "  \$ENV_TEST_TWO     = $ENV_TEST_TWO"
echo "  \$ENV_TEST_EXTRA   = $ENV_TEST_EXTRA"
echo ""

# split out the keys and values and export them
echo "Create the environment variables:"
$( echo "$ENV" | jq -r 'keys[] as $k | "export \($k)=\(.[$k])"' )
#
echo "  \$ENV_TEST_ONE   = $ENV_TEST_ONE"
echo "  \$ENV_TEST_TWO   = $ENV_TEST_TWO"
echo "  \$ENV_TEST_EXTRA = $ENV_TEST_EXTRA"

# cleanup the vars
unset ENV_TEST_ONE
unset ENV_TEST_TWO
unset ENV_TEST_EXTRA

echo ""
