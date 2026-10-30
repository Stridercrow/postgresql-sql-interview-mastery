#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <exercise-number>"
  echo "Example: $0 001"
  exit 1
fi

EXERCISE="$1"

if [[ "$EXERCISE" =~ ^[0-9]+$ ]]; then
  EXERCISE="$(printf "%03d" "$((10#$EXERCISE))")"
fi

EXERCISE_DIR="$(find exercises -type d -name "${EXERCISE}-*" | head -n 1)"

if [[ -z "$EXERCISE_DIR" ]]; then
  echo "Exercise $EXERCISE not found."
  exit 1
fi

if ! docker compose ps --status running --services | grep -qx "postgres"; then
  echo "PostgreSQL is not running. Start it with:"
  echo "  docker compose up -d"
  exit 1
fi

echo "Running exercise $EXERCISE..."
echo

{
  cat "$EXERCISE_DIR/solution.sql"
  echo
  cat "$EXERCISE_DIR/test.sql"
} | docker exec -i sql-interview-postgres \
    psql -X -v ON_ERROR_STOP=1 -U interview -d interview

echo
echo "Exercise $EXERCISE completed."
