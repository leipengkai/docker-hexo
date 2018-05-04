#### 为什么将hexo做成Docker镜像
避免每次写文章和发布,还要在安装了Hexo,Nodejs.Docker打包好了一切,只需要运行Docker.


#### 前提条件
1. [install docker](https://www.femn.me/2017/08/04/docker/)

2. 只需要 下面4个挂载的内容到容器即可.
#### 创建和上传镜像
```bash
    docker build -t femn/hexo .
    docker login
    docker push femn/hexo
```

#### 运行镜像
1. pull images
```bash
    docker pull femn/hexo
```
2. run images
```bash
docker run  -it --rm -p 4000:4000 --name femn-hexo  \
    -v /home/femn/.ssh:/home/femn/.ssh \
    -v /home/femn/blog/source:/home/femn/blog/source \
    -v /home/femn/blog/_config.yml:/home/femn/blog/_config.yml \
    -v /home/femn/blog/README.md:/home/femn/blog/README.md \
    -v /home/femn/blog/deploy/leipengkai.github.io:/home/femn/blog/deploy/leipengkai.github.io \
    femn/hexo sh -l
```
#### 效果
如果仅仅是想看hexo博客的效果的话，此镜像还是可以满足的(themes:icarus)
http://localhost:4000

#### 缺点
由于本人能力有限，此镜像只是针对本人使用,但个人觉得Dockerfile,可以供新手参考.

#### 本人使用
```bash
# 在容器中使用
hexo g # 生成静态文件
hexo s # 启动服务
sh ./update_blog.sh "xx"  # 将博客上传到github上
# 再手动将~/blog(将不会有github内容) 上传到gitlab上
```
