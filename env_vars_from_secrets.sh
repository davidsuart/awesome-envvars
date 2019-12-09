#!/usr/bin/env sh

echo "---------- Testing secrets manager json input ----------"
echo ""

# fetch the contents of our ENV input variable
#
echo "Show the received input value in \$ENV:"
echo " \$ENV = $ENV"
echo ""

# ensure our vars do not have anything in them
#
echo "Show that our target env vars are empty:"
echo "  \$ENV_TEST_ONE     = $ENV_TEST_ONE"
echo "  \$ENV_TEST_TWO     = $ENV_TEST_TWO"
echo "  \$ENV_TEST_EXTRA   = $ENV_TEST_EXTRA"
echo ""

# use jq to enumerate the keys and values and pass to export
#
echo "Split and export the keys and values from \$ENV ..."
echo "  \$( echo \"\$ENV\" | jq -r 'keys[] as \$k | \"export \(\$k)=\(.[\$k])\"' )"
$( echo "$ENV" | jq -r 'keys[] as $k | "export \($k)=\(.[$k])"' )
echo ""

# check our vars are now populated
#
echo "And verify them:"
echo "  \$ENV_TEST_ONE   = $ENV_TEST_ONE"
echo "  \$ENV_TEST_TWO   = $ENV_TEST_TWO"
echo "  \$ENV_TEST_EXTRA = $ENV_TEST_EXTRA"
echo ""

# cleanup
#
unset ENV_TEST_ONE
unset ENV_TEST_TWO
unset ENV_TEST_EXTRA
