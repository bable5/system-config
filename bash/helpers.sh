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


    GI="git cvsimport"
    CVS_MOD=$1
    REPO_NAME=$2
    CVSIMPORT="$GI -C $REPO_NAME -d $CVSROOT -r cvs -k $CVS_MOD"

    #GIT CVSIMPORT the module
    $CVSIMPORT

    #Create a branch to handle the CVS integration.
    if [ -d "$REPO_NAME" ] ; then
        pushd .
        cd "$REPO_NAME"

        git checkout -b cvsintegration
        git checkout master
        git config cvsimport.r cvs
        git config cvsimport.d $CVSROOT
        git config cvsimport.module $CVS_MOD

        popd
    else
        echo "Could not find dir $REPO_NAME. Did the cvsimport fail?"
        return 1
    fi
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

function tex-spellcheck {
    for f in $@ ; do
        aspell -t -c $f
    done
}

function fix-git-ws-errors {
    gitroot=$(git rev-parse --show-toplevel)

    if [ -z "$gitroot" ] ; then
        echo "Not a git repo. Exiting."
        return 1
    else
        #save the curren dir to return to when finished
        pushd .
        #move to the root, ensure path names correct
        cd "$gitroot"
    fi

    if git rev-parse --verify HEAD >/dev/null 2>&1 ; then
       against=HEAD
    else
       # Initial commit: diff against an empty tree object
       against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
    fi

    #loop of the error messages from git diff-index looking for file/line number pairs to fix
    for fix in $(git diff-index --check --cached HEAD -- | grep "whitespace" | cut -d":" -f1,2)
    do
       file=$(echo "$fix" | cut -d: -f1)
       line=$(echo "$fix" | cut -d: -f2)

       echo "Removing trailing whitespace from $fix"
       sed -i.bak  "${line} s/[ \t]*$//" $file

       rm "$file.bak"
    done

    #Leave things where they were.
    popd
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

