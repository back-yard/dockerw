#!/usr/bin/env bash

release_name=`lsb_release -csu 2> /dev/null || lsb_release -cs 2> /dev/null`
[[ "$release_name" = "" ]] && release_name="xenial"

# adding ppa
if [[ -f /etc/apt/sources.list.d/docker.list ]]; then
  echo "########## PPA already added. Skipping ..."
else
  echo "########## adding docker ppa ..."
  echo "   ==> importing gpg keys..."
  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A91 > /dev/null
  sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys F76221572C52609D > /dev/null
  echo "deb http://apt.dockerproject.org/repo ubuntu-${release_name} main" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  echo "   ==> updating cache..."
  sudo apt-get update -y --force-yes > /dev/null
fi

# installing
if which docker > /dev/null ; then
  echo "########## docker already installed. Skipping ..."
else
  echo "########## Installing docker ..."
  echo "   ==> creating docker data directory in home partition ..."
  sudo mkdir -p /home/docker_data_dir > /dev/null
  pushd /var/lib/ > /dev/null
  sudo ln -s /home/docker_data_dir docker > /dev/null
  popd > /dev/null
  echo "   ==> https support for apt keys..."
  sudo apt-get install apt-transport-https ca-certificates -y --force-yes > /dev/null
  echo "   ==> resolving dependencies..."
  sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual -y --force-yes > /dev/null
  sudo apt-get purge lxc-docker -y --force-yes > /dev/null
  echo "   ==> installing docker engine..."
  sudo apt-get install docker-engine -y --force-yes > /dev/null
  echo "   ==> update user permission..."
  sudo groupadd docker > /dev/null
  sudo gpasswd -a ${USER} docker > /dev/null
  echo "   ==> restart docker service..."
  sudo service docker restart > /dev/null
fi

