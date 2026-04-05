#!/bin/bash

# Configuration
LOOP_COUNT=3
COMMAND="../gcloud.par beta orchestration-pipelines deploy --environment=dev"
LOG_FILE="pipelines_tests/deploy_loop.log"
TRIGGER_FILE="pipelines_tests/trigger.txt"

# Ensure we are in the repo root
cd "$(dirname "$0")/.."

echo "Starting loop: running '$COMMAND' $LOOP_COUNT times."
echo "Logging output to $LOG_FILE"
echo "==========================================" > "$LOG_FILE"
echo "Started at: $(date)" >> "$LOG_FILE"
echo "==========================================" >> "$LOG_FILE"

for ((i=1; i<=LOOP_COUNT; i++))
do
  echo "----------------------------------------" >> "$LOG_FILE"
  echo "Iteration $i of $LOOP_COUNT" >> "$LOG_FILE"
  echo "Started at: $(date)" >> "$LOG_FILE"
  echo "----------------------------------------" >> "$LOG_FILE"
  
  # 1. Modify state
  echo "Iteration $i at $(date)" >> "$TRIGGER_FILE"
  
  # 2. Commit and push
  echo "Committing changes..." >> "$LOG_FILE"
  git add . >> "$LOG_FILE" 2>&1
  git commit -m "Automated test commit - iteration $i" >> "$LOG_FILE" 2>&1
  git push origin main >> "$LOG_FILE" 2>&1
  
  # 3. Deploy
  echo "Running deploy..." >> "$LOG_FILE"
  $COMMAND >> "$LOG_FILE" 2>&1
  
  EXIT_CODE=$?
  
  echo "----------------------------------------" >> "$LOG_FILE"
  echo "Finished iteration $i with exit code $EXIT_CODE" >> "$LOG_FILE"
  echo "Ended at: $(date)" >> "$LOG_FILE"
  echo "----------------------------------------" >> "$LOG_FILE"
  
  sleep 2
done

echo "==========================================" >> "$LOG_FILE"
echo "Finished loop at: $(date)" >> "$LOG_FILE"
echo "==========================================" >> "$LOG_FILE"

echo "Loop finished. Check $LOG_FILE for details."
