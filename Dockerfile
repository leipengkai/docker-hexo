FROM alpine
MAINTAINER leipengkai 

ENV gitname leipengkai
ENV useremail leipengkai@gmail.com

ENV USERNAME femn
ENV PASSWD root
ENV HOME /home/femn

RUN apk update && apk upgrade \
    && apk add --no-cache bash git openssh vim busybox-suid \
    && apk add --update nodejs nodejs-npm \
    # install hexo and global node packages
    && npm config set unsafe-perm true \
    && npm install hexo-cli -g \
    && npm -g install instant-markdown-d \

    && adduser -h $HOME -u 1000 -D $USERNAME  \
    # setting root passwd
    && echo "root:$PASSWD" | chpasswd 
    # path need export ,but command don't

# RUN a_pass=$(echo root | mkpasswd) && \
    # echo "root:${a_pass}" | chpasswd

RUN \
  # use madir
  su $USERNAME  && cd \
  # config git
  && git config --global user.name $gitname \
  && git config --global user.email $useremail \
  && mkdir blog && cd blog  \
  && hexo init && npm install \
  && npm install prompt \
  && npm install jquery \
  # install plugins for hexo
  && npm install hexo-deployer-git --save \
  && npm install -S hexo-generator-json-content \
  ## deploy githbub 
  && mkdir -p deploy/leipengkai.github.io \
  && cd deploy/leipengkai.github.io \
  && git init \
  && git remote add origin https://github.com/leipengkai/leipengkai.github.io.git 
  # && cd ../../source/_posts \ rm -rf hello-world.md

WORKDIR $HOME

EXPOSE 4000

COPY blog/_config.yml blog/_config.yml

COPY blog/themes blog/themes

COPY .vimrc .vimrc

COPY .vim .vim

COPY update_blog.sh blog/update_blog.sh

COPY aliases.sh /etc/profile.d/

VOLUME ["$HOME/blog/source","$HOME/blog/themes", "$HOME/.ssh"]

RUN \
    chown -R $USERNAME:$USERNAME $HOME \
    # cd general user
    && su $USERNAME  && cd $HOME/blog

USER $USERNAME 

WORKDIR $HOME/blog
# COPY docker-entrypoint.sh /docker-entrypoint.sh
# ENTRYPOINT ["/bin/sh", "-c","/docker-entrypoint.sh"]

CMD ["/bin/sh"]
