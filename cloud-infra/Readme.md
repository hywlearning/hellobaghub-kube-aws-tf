scp -i cnfp-sg-key.pem -r ./templates ubuntu@52.74.175.121:/home/ubuntu
scp -i cnfp-sg-key.pem -r cnfp-sg-key.pem ubuntu@18.142.226.43:/home/ubuntu

chmod +x templates/master.sh.tpl    # Make the script executable
bash templates/master.sh.tpl 

    "ec2-jumphost" = "10.0.10.202"
    "ec2-master" = "10.0.110.187"
    "ec2-worker" = "10.0.110.63"
    "ec2-worker2" = "10.0.120.176"
    "ec2_jumphost_publicip" = "18.139.83.38"
    "vpc" = "vpc-0306b42ebef7bc4ae"

ssh -i cnfp-sg-key.pem ubuntu@18.139.83.38

ssh -i cnfp-sg-key.pem ec2-user@13.250.100.105
scp -i cnfp-sg-key.pem -r cnfp-sg-key.pem ec2-user@13.250.100.105:/home/ec2-user

Master
kubectl patch ingress hbg-ingress-host -p '{"metadata":{"finalizers":[]}}' --type=merge

ssh -i cnfp-sg-key.pem ec2-user@10.0.110.72

Worker
ssh -i cnfp-sg-key.pem ec2-user@10.0.110.168

kubectl label nodes k8ku-wrk-1 role=worker

aws s3 ls s3://hellobaghubs3/

sudo $HOME/master.sh bucket_name=hellobaghubs3
kubeadm token create --print-join-command


infra_info = [
  {
    "ec2-jumphost" = "10.0.10.24"
    "ec2-master" = "10.0.110.102"
    "ec2-worker" = "10.0.110.114"
    "ec2-worker2" = "10.0.120.147"
    "ec2_jumphost_publicip" = "13.250.100.105"
    "vpc" = "vpc-08b8d0ced38a98c9f"
  },


kubectl create configmap default-content --from-file=default.html


kubeadm join 10.0.2.104:6443 --token yhagnh.n0wnmtwibz2ntfs0 --discovery-token-ca-cert-hash sha256:0d5dc06ddf0d02e3957e6865c7449c7e0da28c07fa8319df45195fb765ca102b 

sudo kubeadm init --apiserver-advertise-address="10.0.2.104" --apiserver-cert-extra-sans="10.0.2.104" --pod-network-cidr="192.168.0.0/16" --node-name "k8s-msr-1" --ignore-preflight-errors Swap
  kubeadm join 10.0.2.123:6443 --token j0dbkx.v5jr9ukd5klsrzf8 --discovery-token-ca-cert-hash sha256:3147f2bc05d7cba28232cf7d7c48641027e5d7fc36fb216ade433a5439533939 

hbg-app-alb-885292341.ap-southeast-1.elb.amazonaws.com

10.0.2.235 k8s-msr-1
10.0.2.80 k8s-wkr-1
10.0.1.33 jumphost
  
kubeadm join 10.0.2.235:6443 --token xpb3tf.mqjo4lrqq8tfv0jp \
        --discovery-token-ca-cert-hash sha256:df5a4168e41083262adc2fd060b94e3fd59f63b5ed72ba02a57f87e3c98f59bb 

sudo nano /etc/kubernetes/manifests/kube-apiserver.yaml

#restart kubelet for api-server
sudo systemctl daemon-reexec
sudo systemctl restart kubelet

#reset cluster
sudo kubeadm reset -f
sudo rm -rf /etc/cni/net.d/*
sudo systemctl restart containerd
#initiazlie back
# If your VPC CIDR is 10.0.0.0/16, use:
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=$(hostname -I | awk '{print $1}')

# If your VPC CIDR is 192.168.0.0/16, use:
# sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$(hostname -I | awk '{print $1}')

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

infra_info = [
  {
    "ec2-jumphost" = "10.0.1.189"
    "ec2-master" = "10.0.2.57"
    "ec2-workder" = "10.0.2.78"
    "ec2_jumphost_publicip" = "3.1.211.114"
    "vpc" = "vpc-0d2664c640a125f4b"
  },
]



