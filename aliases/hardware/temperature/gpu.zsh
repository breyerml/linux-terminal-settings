# ==== GPU ====
if command_exists nvidia-smi ; then             # use nvidia-smi if possible
    function gpu-temp() {                       # display temeprature only
        local gpus="$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)"
        local count=1
        while read -r gpus; do
            echo "GPU $count: $gpus°C"
            counter=$((counter + 1))
        done <<< "$gpus"
        echo 
    }
else
    # TODO: gpu-temp for AMD
fi