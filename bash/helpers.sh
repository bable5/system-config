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

function clone-missing-git-repos {
    if [ $# -lt 2 ] ; then
        echo "Usage <url> <file.lst>"
        return 1
    fi
    repourl=$1
    listfile=$2
    
    for repo in $(cat $listfile) ; do
        if [ ! -d $repo ] ; then
            git clone "$repourl/$repo.git" 
        fi
    done
}

