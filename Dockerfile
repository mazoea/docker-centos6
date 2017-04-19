FROM centos:6.6

MAINTAINER jm

WORKDIR /opt

RUN yum update -y && \
    yum install -y sudo && \
    yum install -y centos-release-scl-rh && \
    yum install -y git curl unzip iotop htop wget tar openssh-clients file && \
    yum install -y gcc-c++ make autoconf automake mlocate links libtool dos2unix && \
    yum install -y cloc xpdf autoconf && \
    yum install -y bzip2-devel openssl-devel freetype-devel sqlite-devel readline-devel cloc && \
    yum install -y python-openssl  || true && \
    yum install -y 'libffi-devel*' || true && \
    yum install -y devtoolset-3-gcc devtoolset-3-gcc-c++

ENV CC=/opt/rh/devtoolset-3/root/usr/bin/gcc  
ENV CPP=/opt/rh/devtoolset-3/root/usr/bin/cpp
ENV CXX=/opt/rh/devtoolset-3/root/usr/bin/g++

RUN curl --silent --location https://rpm.nodesource.com/setup_4.x | bash - ; \
    yum install -y nodejs && \
    npm install npm -g

RUN VER=3.7.2 PACKAGE=cmake ; git clone git://cmake.org/$PACKAGE.git --branch v$VER --depth 1 && \
    cd $PACKAGE && \
    ./bootstrap --prefix=/usr && \
    make  && \
    ./bin/cmake -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_USE_OPENSSL:BOOL=ON . && \
    make install

RUN VER=2.7.8 PACKAGE=Python-$VER ; cd /opt && URL=http://www.python.org/ftp/python/$VER/$PACKAGE.tgz wget -q --no-check-certificate $URL
    tar xzvf $PACKAGE.tgz > /dev/null
    cd $PACKAGE
    ./configure --prefix=/usr/ > /dev/null
    make > /dev/null
    sudo make altinstall > /dev/null
