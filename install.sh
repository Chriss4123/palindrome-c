if [[ "$EUID" != 0 ]]
then
    echo "Sudo permission is required to install this program.";
    exit;
fi

declare cinstalled=0;
declare install=0;
declare installed=0;

function Exit() {

    if [ $cinstalled == 1 ]
        then
            sudo rm -f -rf palindromeCzTHnCBB20T7xPOsDu7u6Q381bsOvp3yCqo57o51wbeLmLlAXqETUaegmOUN1IHP.c
    fi 

    if [ $install == 1 ]
        then
            sudo rm -f -rf palindromeCzTHnCBB20T7xPOsDu7u6Q381bsOvp3yCqo57o51wbeLmLlAXqETUaegmOUN1IHP
    fi

    if [ $installed == 1 ]
        then
            sudo rm -f -rf /usr/bin/palindrome
    fi

printf "Done cleaning up.\n"

exit;

}

if test -f "/usr/bin/make"
then
    declare gccexists=1;
else
    printf "\nmake not found, but can be installed with: \n\nsudo apt install make\n\n";
    Exit;
fi

declare ins=0;

function sigInt() {
    ((ins=$ins+1))

    if [ $ins == 1 ]
    then
        printf "\nCleaning up...\n";
        printf "\nPress ^C one more time to force quit.\n";
        Exit;
    else
       printf "\n";
       exit;
       return -1;
    fi
    
}

trap 'sigInt' SIGINT

function userInput() {
    read;

    if [ ${REPLY} == "y" ] || [ ${REPLY} == "n" ]
    then
        if [ ${REPLY} == "y" ]
        then
            return 1;
        else
            return 0;
        fi
    else
        echo "$1";
        userInput "$1";
    fi

}

function makeFile() {
            sudo rm -f -rf /usr/bin/palindrome
            sudo rm -f -rf palindromeCzTHnCBB20T7xPOsDu7u6Q381bsOvp3yCqo57o51wbeLmLlAXqETUaegmOUN1IHP.c
            sudo rm -f -rf palindromeCzTHnCBB20T7xPOsDu7u6Q381bsOvp3yCqo57o51wbeLmLlAXqETUaegmOUN1IHP
            touch "palindromeCzTHnCBB20T7xPOsDu7u6Q381bsOvp3yCqo57o51wbeLmLlAXqETUaegmOUN1IHP.c";
            cinstalled=1;
            curl -o- -s "https://raw.githubusercontent.com/Chriss4123/palindrome-c/main/palindrome.c" | cat > palindromeCzTHnCBB20T7xPOsDu7u6Q381bsOvp3yCqo57o51wbeLmLlAXqETUaegmOUN1IHP.c
            echo "Download complete";
            install=1;
            make -s palindromeCzTHnCBB20T7xPOsDu7u6Q381bsOvp3yCqo57o51wbeLmLlAXqETUaegmOUN1IHP;
            echo "Compiling complete";
            installed=1;
            sudo cp -f palindromeCzTHnCBB20T7xPOsDu7u6Q381bsOvp3yCqo57o51wbeLmLlAXqETUaegmOUN1IHP /usr/bin/palindrome
            echo "File appended";
            installed=0;

            echo "Cleaning up...";
            rm palindromeCzTHnCBB20T7xPOsDu7u6Q381bsOvp3yCqo57o51wbeLmLlAXqETUaegmOUN1IHP.c;
            cinstalled=0;
            rm palindromeCzTHnCBB20T7xPOsDu7u6Q381bsOvp3yCqo57o51wbeLmLlAXqETUaegmOUN1IHP;
            install=0;
            echo "Done cleaning up";
            exit;
}

FILE=/usr/bin/palindrome
if test -f "$FILE"; then
    echo "File $FILE exists. Overwrite? y/n";
    userInput "Invalid input. Overwrite file? y/n";
    if [ $? == 1 ]
        then
            makeFile;
        
        else
            printf "Sorry to see you go!\n";
            Exit;
    fi
else

makeFile;

fi
