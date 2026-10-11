FROM charade/xlibbox:basic
RUN apt-get update -y
MAINTAINER lxx
### avoid RPC error with https ###
RUN git config --global http.sslVerify false
RUN git config --global http.postBuffer 1048576000

### install grammy (require git-lfs) ###
RUN cd $HOME/setup && git clone -b paired https://github.com/labxscut/grammy.git
RUN cd $HOME/setup/grammy && python setup.py install --force
RUN wget http://app.shenwei.me/data/seqkit/seqkit_linux_amd64.tar.gz && tar -zxvf *.tar.gz && cp seqkit /usr/local/bin/
RUN wget http://opengene.org/fastp/fastp && chmod a+x ./fastp && cp fastp /usr/local/bin/ && apt-get install time 
