#!/usr/bin/env sh

# Artifical delay for demo (To keep console output cosmetically clean)
sleep 5

/bin/sh "env_vars_from_secrets.sh"

echo "---------- Execution completed ----------"
