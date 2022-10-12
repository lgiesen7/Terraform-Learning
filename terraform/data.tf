data "vsphere_datacenter" "datacenter" {
  count         = length(var.vms)
  name          = var.vms[count.index].location.datacenter
}

data "vsphere_host" "esxi_hosts" {
  depends_on    = [data.vsphere_datacenter.datacenter]
  count         = length(var.vms)
  name          = var.vms[count.index].general.esxi_host
  datacenter_id = data.vsphere_datacenter.datacenter[count.index].id
}

data "vsphere_datastore" "datastores" {
  depends_on    = [data.vsphere_datacenter.datacenter]
  count		      = length(var.vms)
  datacenter_id = data.vsphere_datacenter.datacenter[count.index].id
  name          = var.vms[count.index].general.datastore
}

data "vsphere_compute_cluster" "compute_cluster" {
  depends_on        = [data.vsphere_datacenter.datacenter]
  count		          = length(var.vms)
  name              = var.vms[count.index].location.cluster
  datacenter_id     = data.vsphere_datacenter.datacenter[count.index].id
}

data "vsphere_network" "external_network" {
  depends_on    = [data.vsphere_datacenter.datacenter]
  count		      = length(var.vms)
  name          = var.vms[count.index].network.external_network
  datacenter_id = data.vsphere_datacenter.datacenter[count.index].id
}

data "vsphere_virtual_machine" "template" {
  depends_on    = [data.vsphere_datacenter.datacenter]
  count		      = length(var.vms)
  name          = var.vms[count.index].general.image
  datacenter_id = data.vsphere_datacenter.datacenter[count.index].id
}

data "vsphere_resource_pool" "resource_pool" {
  depends_on    = [data.vsphere_datacenter.datacenter]
  count		      = length(var.vms)
  name          = var.vms[count.index].location.resource_pool
  datacenter_id = data.vsphere_datacenter.datacenter[count.index].id
}

# CUSTOM ATTRIBUTES NEED TO BE DECLARED BEFOREHAND
# SEE https://docs.vmware.com/en/VMware-vSphere/6.5/com.vmware.vsphere.vcenterhost.doc/GUID-621BC36D-D077-4AE2-9604-42791057AFAF.html
# FOR MORE INFORMATION
data "vsphere_custom_attribute" "availability_level" {
  name                = "Availability level"
}

data "vsphere_custom_attribute" "contact_person" {
  name                = "Contact person"
}

data "vsphere_custom_attribute" "vm_flavor" {
  name                = "VM Flavor"
}