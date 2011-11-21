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
  
    git-doall "pull" $1
}

function git-push-all {
    if [ "$#" -lt 1 ] ; then
        echo "usage: git-push-all <repolist>"
        return 1
    fi
  
    git-doall "push" $1
}

function git-doall {
    gitcmd=$1
    repolist=$2

    there=$(pwd)    
    
    for repo in $(cat $repolist) ; do
        echo "$gitcmd-ing $repo"
        cd $repo
        echo $(pwd)
        git "$gitcmd"
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

