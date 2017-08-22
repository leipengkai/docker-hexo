#!/bin/sh 
set -e
echo "$@" | awk -F ' ' '{print $1}' | xargs git config --global user.name

echo "$@" | awk -F ' ' '{print $2}' | xargs git config --global user.email

if [ "$3" = 's' ] || [ "$3" = 'server' ]; then
    set -- /usr/local/bin/hexo s -p 4000
fi
   
if [ "$3" = 'd' ] || [ "$3" = 'deploy' ]; then
    set -- /usr/local/bin/hexo clean && /usr/local/bin/hexo d -g
fi
        
exec "$@"   
#if [ $# -eq 0 ]
#then
    #echo 'hexo container'
    #exec "$@" 
#elif [ $# -eq 1 ] && [ "$1" = 's' ]
#then
   #set -- /usr/local/bin/hexo s -p 4000
    #exec "$@" 
#else
    #echo "$@" | awk -F ' ' '{print $1}' | xargs git config --global user.name
#
    #echo "$@" | awk -F ' ' '{print $2}' | xargs git config --global user.email
      #
    #if [ "$3" = 'd' ] || [ "$3" = 'deploy' ]; then
        #set -- /usr/local/bin/hexo clean && /usr/local/bin/hexo d -g
        #exec "$@" 
    #fi
#fi
    #
#exec "$@" 
