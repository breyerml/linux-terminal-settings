# ==== Memory ====
if (( $+commands[pydf] )) ; then
    alias memory='pydf -h'                      # print memory usage using pydf if possible
else
    alias memory='df -h'                        # use normal df to print memory usage
fi