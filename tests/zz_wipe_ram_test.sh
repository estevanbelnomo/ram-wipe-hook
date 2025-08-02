#!/usr/bin/env bash

# Tests for zz_wipe_ram using a minimal shunit2 framework.

setUp() {
  TEST_TMPDIR="$(mktemp -d)"
  STUB_BIN="$TEST_TMPDIR/bin"
  mkdir -p "$STUB_BIN"
  PATH="$STUB_BIN:$PATH"

  # stub awk to control memory values
  cat >"$STUB_BIN/awk" <<'EOT'
#!/usr/bin/env bash
if [[ "$1" == *MemTotal* ]]; then
  # Report 2 GiB total memory
  echo 2147483648
elif [[ "$1" == *MemAvailable* ]]; then
  # Use MEM_AVAILABLE env var or default to reserve + 2 chunks
  echo "${MEM_AVAILABLE:-1342177280}"
fi
EOT
  chmod +x "$STUB_BIN/awk"

  # stub nproc
  cat >"$STUB_BIN/nproc" <<'EOT'
#!/usr/bin/env bash
echo 2
EOT
  chmod +x "$STUB_BIN/nproc"

  # stub utilities to no-ops
  for cmd in dd mount swapoff stty sleep sync umount; do
    cat >"$STUB_BIN/$cmd" <<'EOT'
#!/usr/bin/env bash
exit 0
EOT
    chmod +x "$STUB_BIN/$cmd"
  done

  # default mkdir delegates to real
  cat >"$STUB_BIN/mkdir" <<'EOT'
#!/usr/bin/env bash
/bin/mkdir "$@"
EOT
  chmod +x "$STUB_BIN/mkdir"
}

tearDown() {
  rm -rf /run/ramwipe "$TEST_TMPDIR"
}

test_normal_execution() {
  ./zz_wipe_ram poweroff >/dev/null 2>&1
  status=$?
  assertEquals 0 "$status"
}

test_setup_failure() {
  # override mkdir stub to simulate failure
  cat >"$STUB_BIN/mkdir" <<'EOT'
#!/usr/bin/env bash
exit 1
EOT
  chmod +x "$STUB_BIN/mkdir"

  ./zz_wipe_ram poweroff >/dev/null 2>&1
  status=$?
  assertNotEquals 0 "$status"
}

test_already_cleared_ram() {
  MEM_AVAILABLE=1073741824 ./zz_wipe_ram poweroff >/dev/null 2>&1
  status=$?
  assertEquals 0 "$status"
}

# shellcheck source=tests/shunit2
. "$(dirname "$0")/shunit2"

