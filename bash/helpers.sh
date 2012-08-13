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

# Create a git-controlled mirror of a CVS module
# Assumes CVSROOT has been set up correctly.
function git-cvs-mirror {
    if [ $# -lt 2 ] ; then
        echo "Found $# arguments, needed 2"
        echo "Usage git-cvs-mirror <module-name> <repo-name>"
        return 1
    fi
    
    if [ ! -n "$CVSROOT" ] ; then
        echo "CVSROOT not set. Set to location of the cvsroot"
        return 1
    fi


    GI_FLAGS="-p -x -v -d"
    GI="git cvsimport"
    
    CVS_MOD=$1
    REPO_NAME=$2

    CVSIMPORT="$GI -C $REPO_NAME $GI_FLAGS $CVSROOT $CVS_MOD"
 

    #GIT CVSIMPORT the module
    $CVSIMPORT
    #Create a bare clone to be the central version of truth
    git clone --bare "$REPO_NAME" "$REPO_NAME.git"

    #Create a branch to handle the CVS integration.
    pushd .
    if [ -d "$REPO_NAME" ] ; then
        cd "$REPO_NAME"
    else 
        echo "Could not find dir $REPO_NAME. Did the cvsimport fail?"
        return 1
    fi
    git checkout -b cvsintegration
    git checkout master
    popd 
}

function make-on-change {
    if [ $# -lt 2 ] ; then
        echo "Nothing to watch!"
        return
    else
        dir=$1
        shift 
        #echo "Remaining args $@"
    fi
    

    while inotifywait -r -e modify $dir ; do
        make $@
    done
}

#Adds a timestamp to the outputs of a program
#From redditor WASDx on reddit script swap
#http://www.reddit.com/r/commandline/comments/trx74/i_made_a_small_script_to_add_timestamps_to_output/
function timestamp() {
    while read line; do
        clock=$(date '+(%H:%M:%S)')
        echo "$clock $line"
    done
}

complete -F _todo todo

