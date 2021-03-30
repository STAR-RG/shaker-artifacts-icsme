#!/bin/bash

function clone(){
    url=$1;
    f=$url
    cd $f
    mkdir -p rerunsS

    #reponame=$(echo ${url::-1} | awk -F/ '{print $NF}' | sed -e 's/.git$//');
    #if ! (git clone --depth=1 $url  && cd "$(basename "$_" .git)") then # if the repository already exists
    #    return 1
    #fi
    #cd $reponame;
    #if [ $f == "dagger" ]; then
    #cd $1
    for i in $(seq 4 11); # 3 vezes TODO
    do
        for j in $(seq 4); # configuracoes
        do
            echo $f $i $j
                mvn clean > /dev/null
                # iniciar strss com a config
                
                echo "start"
                mvn surefire-report:report 2>&1 > rerunsS/rerun.$i.$j.txt
                
                cat rerunsS/rerun.$i.$j.txt | grep "Tests run:" > rerunsS/rerun.MIN-$i.$j.txt 
                
               
                echo "done"
        done
        sleep 5
    done
    cd ..

}

for line in *; do
    if [ -d "$line" ]; then
        clone $line
    fi
done
shutdown now