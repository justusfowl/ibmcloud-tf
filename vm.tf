resource "ibm_is_security_group" "sg1" {
    name = "${var.env_prefix}-sg1"
    vpc  = ibm_is_vpc.vpc.id

    depends_on = [
        ibm_is_vpc.vpc
    ]
}

# allow all incoming network traffic on port 22
resource "ibm_is_security_group_rule" "ingress_ssh_all" {
    group     = ibm_is_security_group.sg1.id
    direction = "inbound"
    remote    = "0.0.0.0/0"

    tcp {
      port_min = 22
      port_max = 22
    }
}

data "ibm_is_image" "centos" {
    name = "ibm-centos-7-6-minimal-amd64-1"
}

resource "ibm_is_ssh_key" "ssh_key_id" {
  name       = "example-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCKVmnMOlHKcZK8tpt3MP1lqOLAcqcJzhsvJcjscgVERRN7/9484SOBJ3HSKxxNG5JN8owAjy5f9yYwcUg+JaUVuytn5Pv3aeYROHGGg+5G346xaq3DAwX6Y5ykr2fvjObgncQBnuU5KHWCECO/4h8uWuwh/kfniXPVjFToc+gnkqA+3RKpAecZhFXwfalQ9mMuYGFxn+fwn8cYEApsJbsEmb0iJwPiZ5hjFC8wREuiTlhPHDgkBLOiycd20op2nXzDbHfCHInquEe/gYxEitALONxm0swBOwJZwlTDOB7C6y2dzlrtxr1L59m7pCkWI4EtTRLvleehBoj3u7jB4usR"
}

resource "ibm_is_instance" "vsi1" {
    name    = "${var.env_prefix}-vsi1"
    vpc     = ibm_is_vpc.vpc.id
    zone    = var.region
    keys    = [ibm_is_ssh_key.ssh_key_id.id]
    image   = data.ibm_is_image.centos.id
    profile = "cx2-2x4"

    primary_network_interface {
        subnet          = ibm_is_subnet.subnet1.id
        security_groups = [ibm_is_security_group.sg1.id]
    }

    depends_on = [
        ibm_is_vpc.vpc
    ]
}

resource "ibm_is_floating_ip" "fip1" {
    name   = "${var.env_prefix}-fip1"
    target = ibm_is_instance.vsi1.primary_network_interface[0].id
}

output "sshcommand" {
    value = "ssh root@${ibm_is_floating_ip.fip1.address}"
}