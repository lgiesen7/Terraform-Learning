resource "vsphere_virtual_machine" "vms" {

  # Might have to be enabled for production environment to avoid the connection
  # check, because a connection between terraform and the VM can not be established
  # wait_for_guest_ip_timeout = 0
  # wait_for_guest_net_timeout = 0
  depends_on       = [data.vsphere_virtual_machine.template]
  count		         = length(var.vms)
  name             = var.vms[count.index].general.vm_name
  resource_pool_id = data.vsphere_resource_pool.resource_pool[count.index].id
  datastore_id     = data.vsphere_datastore.datastores[count.index].id
  annotation	     = var.vm_annotation
  folder = var.vms[count.index].location.folder_name

  custom_attributes = tomap({(data.vsphere_custom_attribute.availability_level.id) = (var.vms[count.index].custom_attr.availability_level),
    (data.vsphere_custom_attribute.contact_person.id) = (var.vms[count.index].custom_attr.contact_person)})

  num_cpus = var.vms[count.index].flavor.cpu
  memory   = var.vms[count.index].flavor.ram
  guest_id = var.vms[count.index].general.guest_id

  network_interface {
    network_id = data.vsphere_network.external_network[count.index].id
  }

  dynamic disk {
    for_each = [for i in var.vms[count.index].flavor.disks: {
      size   = i.size
      number = i.number
    }]
    content {
      label = "disk${disk.value.number}"
      size = disk.value.size
      unit_number = disk.value.number
    }
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template[count.index].id

    customize {
      linux_options {
        host_name = var.vms[count.index].general.host_name
        domain = var.vms[count.index].general.domain
      }

      network_interface {
        ipv4_address = var.vms[count.index].network.external_address
        ipv4_netmask = var.vms[count.index].network.external_netmask
      }

      dns_server_list = var.vms[count.index].network.dns_server_list

      ipv4_gateway = var.vms[count.index].network.external_gateway
    }
  }