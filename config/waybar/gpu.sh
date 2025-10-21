#!/bin/sh

metrics=$(amdgpu_top -gm)
if [ -z "$metrics" ]; then
    echo "{\"text\": \"No GPU metrics available\", \"class\": \"gpu\"}"
    exit 0
fi

activity_percentages=$(echo "$metrics" | grep -oP '(?<=activity: )[0-9]+')
activity_percentages=$(echo $activity_percentages | tr '\n' ' ')
IFS=' ' activity_percentages=($activity_percentages)

gfx_activity=${activity_percentages[0]}
umc_activity=${activity_percentages[1]}
mm_activity=${activity_percentages[2]}

printf -v gfx_activity "%2s" $gfx_activity 

echo "{\"text\": \" $gfx_activity%\", \"class\": \"gpu\"}"
