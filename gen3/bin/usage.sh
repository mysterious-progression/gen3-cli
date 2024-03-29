#!/bin/bash

source "${GEN3_CLI_HOME}/gen3/lib/utils.sh"

README="$GEN3_CLI_HOME/docs/README.md"
detail="$1"
PAGER="${PAGER:-less}"

open() {
  local filePath="$1"
  echo "$filePath" | cat - "$filePath" | $PAGER

}
if [[ -z "$detail" ]]; then
  open "$README"
  exit $?
fi

# Try to find an exact match
filePath="$(find "$GEN3_CLI_HOME/docs" -name "${detail}.md" -print | head -1)"
if [[ -n "$filePath" ]]; then
  open "$filePath"
  exit $?
fi

# Try to help the user find what they want
gen3_log_info "Could not find ${detail}.md under $GEN3_CLI_HOME/docs"
gen3_log_info grep "$README"
grep "$detail" "$README"
