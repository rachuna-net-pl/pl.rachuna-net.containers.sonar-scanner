#!/bin/bash
set -euo pipefail

/opt/scripts/gitlab.bash
/opt/scripts/sonarcloud.bash

exec "$@"