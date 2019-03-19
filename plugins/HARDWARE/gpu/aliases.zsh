# ==== GPU ====
if (( $+commands[nvidia-smi] )) ; then          # use nvidia-smi if possible
    alias gpu='nvidia-smi'                      # display full NVIDIA GPU infos
else
    alias gpu='lspci -vnn | \grep VGA -A 12'    # display full GPU info (in case of no NVIDIA GPU is used)
fi