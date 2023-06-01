#!/bin/bash

#set the time for deletion (in second)
TIME=$((3 * 24 * 60 * 60))

#get the current timestamp
Current_time=$(date +%s)

#get a list of all EBS Volumes
VOLUMES=$(aws ec2 describe-volumes --query 'Volumes[?State== 'available'].{ID:VolumeID, Created:CreateTime}' --output text)

#Loop through each volume
while read -r VOLUME; do
   # Extract the volume ID and creation time
   VOLUME_ID=$(echo "$VOLUME" | awk '{print $1}')
   CREATION_TIME=$(echo "$VOLUMES" |awk '{print $2}')



   # Convert creation time to timestamp
   CREATION_TIMESTAMP=$(date -d "$CREATION_TIME" +%s)

   # Calculate the age of the volume 
   AGE=$((TIME - CREATION_TIMESTAMP))

   # Check if the volume is older than the TIME
   if [[ $AGE -gt $TIME ]]; then
       echo "Deleting volume $VOLUME_ID"
       # aws ec2 delete-volume --volume-id "VOLUME_ID"
   fi
done <<< "$VOLUMES" 
