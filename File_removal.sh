#!/bin/bash

folder_path="/home/anshu/sample_project"
three_days_ago=$(date -d "-3 days" +%s)

# Iterate over the files in the folder
for file in $/home/anshu/sample_project/*; do
    # Check if the file is a regular file and not a directory
    if [[ -f "$file" ]]; then
        # Get the last modified time of the file
        modified_time=$(stat -c %Y "$file")

        # Check if the file was modified three days ago or earlier
        if (( modified_time < three_days_ago )); then
            # Remove the file
            rm "$file"
            echo "Deleted file: $file"
        fi
    fi
done

echo "File removal process completed."
