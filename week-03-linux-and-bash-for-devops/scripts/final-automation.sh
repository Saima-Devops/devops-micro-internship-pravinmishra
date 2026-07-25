#!/bin/bash

user="Your Name"

tools=("Git" "Docker" "Linux" "Jenkins")

show_user() {
    echo "User: $user"
}

show_tools() {
    echo "Installed Tools:"
    for tool in "${tools[@]}"
    do
        echo "- $tool"
    done
}

check_directory() {
    if [ -d "../test-folder" ]
    then
        echo "Directory exists."
    else
        echo "Directory not found."
    fi
}

main() {
    echo "===== Bash Automation Script ====="

    show_user

    show_tools

    check_directory

    echo "Automation Complete!"
}

main
