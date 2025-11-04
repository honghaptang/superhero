#!/bin/bash

# Random Commit Generator - Simulates Git Activity
# Usage: ./random_commits.sh [max_commits] [commit_message_prefix]
#        Defaults to 100 max commits with "Update" prefix

set -e  # Exit on any error

# Configuration
MAX_COMMITS=${1:-100}  # Default max commits: 100
if [[ $MAX_COMMITS -lt 1 || $MAX_COMMITS -gt 100 ]]; then
    echo "Error: Max commits must be between 1-100" >&2
    exit 1
fi

MSG_PREFIX=${2:-"Update"}  # Default commit message prefix
TEMP_FILE=".activity_simulator.tmp"
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

# Verify we're in a git repository
if [[ -z "$REPO_ROOT" ]]; then
    echo "Error: Not in a git repository!" >&2
    exit 1
fi

# Verify working directory is clean
if ! git diff-index --quiet HEAD --; then
    echo "Error: Uncommitted changes detected! Please commit/stash first." >&2
    exit 1
fi

# Generate random commit count (1 to MAX_COMMITS)
COMMIT_COUNT=$((RANDOM % MAX_COMMITS + 1))
echo "Generating $COMMIT_COUNT random commits..."

# Create temporary file in repo root
TEMP_PATH="$REPO_ROOT/$TEMP_FILE"
touch "$TEMP_PATH"

# Generate commits
for ((i=1; i<=COMMIT_COUNT; i++)); do
    # Modify temporary file (changes content each time)
    echo "$(date): Random activity #$i" > "$TEMP_PATH"
    
    # Stage changes
    git add "$TEMP_FILE"
    
    # Create commit with random message
    COMMIT_MSG="$MSG_PREFIX $(date '+%Y-%m-%d %H:%M:%S') #$i"
    git commit -m "$COMMIT_MSG" --quiet
    
    # Optional: Add small delay to avoid timestamp collisions
    sleep 0.1
done

# Clean up temporary file
git rm --quiet "$TEMP_FILE"
git commit -m "Cleanup activity simulation" --quiet

echo "Done! Generated $COMMIT_COUNT commits."
echo "Tip: Use 'git log --oneline -n $((COMMIT_COUNT+1))' to verify"
