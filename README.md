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

## To connect to the EC2 Instances in the private Subnet
NOTE: This section is just to smoke test while developing. This puts the private key on the Bastion (not smart!). See the "towardsdatascience" link below for how to set up SSH with ProxyCommand to proxy SSH commands through the Bastion into the instances on the Private Subnet without putting the private key on the Bastion. 

Convert the 'pem' to base64, from PowerShell:

```
$theFilePath = "$($pwd)\ssh-cloud-private-dns.pem"
$e = [Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes(([System.IO.File]::ReadAllText($theFilePath) -replace '\r', '')))
scb $e
```

To place the private key on the Bastion, connect using AWS and then:

```
echo "paste the content of scb above" | base64 --decode > ssh-cloud-private-dns.pem
chmod 600 ssh-cloud-private-dns.pem
```

To SSH from the Bastion to the Vm Server running in (say) set 1:

```
ssh -i ./ssh-cloud-private-dns.pem ec2-user@set1-server.testytesty.com
```

# Design Considerations
There are a number of constraints here:

1. The networking is hard coded and a bit hackey-wackey for now. 
2. SSH is used to communicate between private EC2 Instances and the Bastion (same keypair)
3. I have created a module out of the 'network layer'; the network layer exports (as a map) all of its context. This is not so much a reusable module as an abstraction for this use case. 
4. This uses private fixed IPs for now: I will update this in future to use DHCP Options and other approaches. 

# References
| Link | Description |
| ---- | ----------- |
| https://towardsdatascience.com/connecting-to-an-ec2-instance-in-a-private-subnet-on-aws-38a3b86f58fb | This link provides a solution for Bastion + Private Subnet + VPC + Public Subnet + IGW and how to set up an SSH Jump Box through a Bastion; I have borrowed extensively from this |
