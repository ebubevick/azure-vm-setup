# Deploy Public VMs
resource "azurerm_network_interface" "public_nic_1" {
  name                = "public-nic-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Network interface IP configuration
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_1.id
  }
}

resource "azurerm_public_ip" "public_ip_1" {
  name                = "public-ip-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Static allocation for the public IP
  allocation_method = "Static"
  sku               = "Standard"
}

resource "azurerm_virtual_machine" "public_vm_1" {
  name                = "public-vm-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Associate the VM with the public NIC
  network_interface_ids = [azurerm_network_interface.public_nic_1.id]
  vm_size               = "Standard_B1s"

  # OS image details
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  # OS disk configuration
  storage_os_disk {
    name              = "public-os-disk-1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  # VM OS profile
  os_profile {
    computer_name  = "publicvm1"
    admin_username = "azureuser"
    admin_password = "P@ssw0rd1234!"

    # Custom data for VM provisioning
    custom_data = <<-EOF
                      #cloud-config
                      package_update: true
                      package_upgrade: true
                      packages:
                        - nginx
                      runcmd:
                        - sudo systemctl start nginx
                        - sudo systemctl enable nginx
                      EOF
  }

  # Linux OS specific profile
  os_profile_linux_config {
    disable_password_authentication = false
  }

  # Tags for resource grouping
  tags = {
    environment = "production"
  }
}

# Un-comment to add Public-VM-2
# resource "azurerm_network_interface" "public_nic_2" {
#   name                = "public-nic-2"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#
#   # Network interface IP configuration
#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.public_subnet_2.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.public_ip_2.id
#   }
# }
#
# resource "azurerm_public_ip" "public_ip_2" {
#   name                = "public-ip-2"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#
#   # Static allocation for the public IP
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }
#
# resource "azurerm_virtual_machine" "public_vm_2" {
#   name                  = "public-vm-2"
#   location              = azurerm_resource_group.rg.location
#   resource_group_name   = azurerm_resource_group.rg.name
#
#   # Associate the VM with the public NIC
#   network_interface_ids = [azurerm_network_interface.public_nic_2.id]
#   vm_size               = "Standard_B2s"
#
#   # OS image details
#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }
#
#   # OS disk configuration
#   storage_os_disk {
#     name              = "public-os-disk-2"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#
#   # VM OS profile
#   os_profile {
#     computer_name  = "publicvm2"
#     admin_username = "azureuser"
#     admin_password = "P@ssw0rd1234!"
#   }
#
#   # Linux OS specific profile
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
#
#   # Tags for resource grouping
#   tags = {
#     environment = "production"
#   }
# }

# Deploy Private VMs
resource "azurerm_network_interface" "private_nic_1" {
  name                = "private-nic-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Network interface IP configuration
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private_subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "private_vm_1" {
  name                = "private-vm-1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Associate the VM with the private NIC
  network_interface_ids = [azurerm_network_interface.private_nic_1.id]
  vm_size               = "Standard_B1s"

  # OS image details
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  # OS disk configuration
  storage_os_disk {
    name              = "private-os-disk-1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  # VM OS profile
  os_profile {
    computer_name  = "privatevm1"
    admin_username = "azureuser"
    admin_password = "P@ssw0rd1234!"
  }

  # Linux OS specific profile
  os_profile_linux_config {
    disable_password_authentication = false
  }

  # Tags for resource grouping
  tags = {
    environment = "production"
  }
}

# Un-Comment to add Private-VM-2
# resource "azurerm_network_interface" "private_nic_2" {
#   name                = "private-nic-2"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#
#   # Network interface IP configuration
#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.private_subnet_2.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }
#
# resource "azurerm_virtual_machine" "private_vm_2" {
#   name                  = "private-vm-2"
#   location              = azurerm_resource_group.rg.location
#   resource_group_name   = azurerm_resource_group.rg.name
#
#   # Associate the VM with the private NIC
#   network_interface_ids = [azurerm_network_interface.private_nic_2.id]
#   vm_size               = "Standard_B2s"
#
#   # OS image details
#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }
#
#   # OS disk configuration
#   storage_os_disk {
#     name              = "private-os-disk-2"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }
#
#   # VM OS profile
#   os_profile {
#     computer_name  = "privatevm2"
#     admin_username = "azureuser"
#     admin_password = "P@ssw0rd1234!"
#   }
#
#   # Linux OS specific profile
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
#
#   # Tags for resource grouping
#   tags = {
#     environment = "production"
#   }
# }
