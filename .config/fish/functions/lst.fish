function lst --wraps=ls\ -R\ --ignore=\'.git\' --description alias\ lst\ ls\ -R\ --ignore=\'.git\'
    ls -R \
        -I .git \
        -I .github \
        $argv

end
