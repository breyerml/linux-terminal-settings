function ram-info() {                           # list RAM info: usage + more infos
    free -h
    if has_elevated_privileges ; then
        echo 
        sudo lshw -short -C memory
    else 
        echo "Error: elevated privileges needed to display more information!"
    fi
}