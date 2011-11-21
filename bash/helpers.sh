function ls_non_git {
for d in $(ls .) ; do
    if [ -d $d  ] ; then
        if [ ! -e "$d/.git" ] ; then
            echo "$d"
        fi
    fi
done
}

function ls_git {

if [ "$#" -ge 1 ] ; then
    dir=$1
else
    dir="."
fi

for d in $(ls $dir) ; do
    if [ -d $d  ] ; then
        if [ -e "$d/.git" ] ; then
            echo "$d"
        fi
    fi
done
}

function git-pull-all {
    if [ "$#" -lt 1 ] ; then
        echo "usage: git-pull-all <repolist>"
        return 1
    fi
    there=$(pwd)    
    repolist=$1
    
    for repo in $(cat $repolist) ; do
        echo "Pulling $repo"
        cd $repo
        echo $(pwd)
        git pull
        cd $there
    done
}

