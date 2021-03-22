# cloud-private-dns (AWS)
Terraform up:

1. VPC
2. Private Subnet + Public Subnet
3. Private DNS Hosted Zone
4. Bastion Server
5. EC2 instances with private (resolvable) DNS names defined as A-Records

The EC2 instances are grouped as 'pairs' (server/client). Each pair knows about the other machine in the pair. The client can SSH only to the server in the pair. 

# Development

## To create the Public / Private KeyPair
Run the following from the 'terraform' folder to generate the public / private key pair:

```bash
ssh-keygen.exe -b 2048 -t rsa -f ./ssh-cloud-private-dns -N '""' -m PEM -C "private-key"
mv ./ssh-cloud-private-dns ./ssh-cloud-private-dns.pem
```

## Bastion Connectivity
To list the outputs of the stack:

```
terraform output
```

To connect to the Bastion:

```
ssh -i ssh-cloud-private-dns.pem ec2-user@...public-ip-of-bastion
```

# Design Considerations
There are a number of constraints here:

1. The networking is hard coded and a bit hackey-wackey for now. 
2. SSH is used to communicate between private EC2 Instances and the Bastion (same keypair)
3. I have created a module out of the 'network layer'; the network layer exports (as a map) all of its context. This is not so much a reusable module as an abstraction for this use case. 

# References
| Link | Description |
| ---- | ----------- |
| https://towardsdatascience.com/connecting-to-an-ec2-instance-in-a-private-subnet-on-aws-38a3b86f58fb | This link provides a solution for Bastion + Private Subnet + VPC + Public Subnet + IGW and how to set up an SSH Jump Box through a Bastion; I have borrowed extensively from this |
