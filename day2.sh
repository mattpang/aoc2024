# run with 
# bash day2.sh inputs/input-2.txt
safe=0
IFS=$'\n' read -d '' -r -a lines < "$1"

function is_valid_sequence {
        local seq=("$@")
        local last_state
        last_state=$(( seq[1] - seq[0] > 0 ? 1 : -1)) 
        local valid_state=1

        for (( i=1; i<${#seq[@]}; i++ )); do
            local diff=$(( seq[i] - seq[i-1] ))
            local abs_diff=$(( diff < 0 ? -diff : diff ))

            if (( abs_diff > 3 )); then
                return 1 # 1 is exit with issues btw
            fi

            local current_state=$(( diff > 0 ? 1 : -1)) 
            
            if (( diff == 0 )); then
                return 1
            fi

            if (( current_state != last_state )); then
                return 1
            fi
            
            last_state=$current_state  
        done

        return 0  
    }

for line in "${lines[@]}"; do
    numbers=($line)
    if is_valid_sequence "${numbers[@]}"; then
        safe=$((safe + 1))
    fi
done

printf "Part 1: %s\n" "$safe"

safe=0 
for line in "${lines[@]}"; do
    numbers=($line)
    valid_with_removal=0

    if is_valid_sequence "${numbers[@]}"; then
        valid_with_removal=1
    else
        for (( z=0; z<=${#numbers[@]}; z++ )); do
            new_sequence=("${numbers[@]:0:z}" "${numbers[@]:z+1}")
            if is_valid_sequence "${new_sequence[@]}"; then
                valid_with_removal=1
                break 
            fi
        done

    fi

    if (( valid_with_removal == 1 )); then
        safe=$((safe + 1))
    fi
done
printf "Part 2: %s\n" "$safe"
