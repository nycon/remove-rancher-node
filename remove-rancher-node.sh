#!/bin/bash
#============================================================================
#title          :remove-rancher-node.sh
#description    :Remove Rancher from Node.
#author         :Marco Stoeckle dq-solutions
#date           :2020-02-10
#version        :0.1
#usage          :./remove-rancher-node.sh
#notes          :
#bash_version   :
#============================================================================

docker rm -f $(docker ps -qa)
docker rmi -f $(docker images -q)
docker volume rm $(docker volume ls -q)
sleep 5
for mount in $(mount | grep tmpfs | grep '/var/lib/kubelet' | awk '{ print $3 }') /var/lib/kubelet /var/lib/rancher; do umount $mount; done
sleep 5
rm -rf /etc/ceph \
       /etc/cni \
       /etc/kubernetes \
       /opt/cni \
       /opt/rke \
       /run/secrets/kubernetes.io \
       /run/calico \
       /run/flannel \
       /var/lib/calico \
       /var/lib/etcd \
       /var/lib/cni \
       /var/lib/kubelet \
       /var/lib/rancher/rke/log \
       /var/log/containers \
       /var/log/pods \
       /var/run/calico \
       /var/lib/rancher \
       /var/lib/kubelet

exit 0


