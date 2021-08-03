resource "azurerm_resource_group" "rg1" {
  name     = "az104-05-vnet0"
  location = "westus"
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "az104-05-vnet0"
  resource_group_name =  azurerm_resource_group.rg1.name
  location            = "westus"
  address_space       = ["10.70.0.0/22"]
}

#create subnet
resource "azurerm_subnet" "subnet1" {
  name                 = "subnet0"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.70.0.0/24"]
}

resource "azurerm_public_ip" "publicip" {
  name                = "public-ip-vm"
  location            = "westus"
  resource_group_name = azurerm_resource_group.rg1.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

#create NIC
resource "azurerm_network_interface" "nic" {
  name                = "vm-nic"
  location            = "westus"
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.publicip.id
  }
}
#create Virtual machine
resource "azurerm_windows_virtual_machine" "azurevm" {
  name                = "az104-07-vm0"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = "westus"
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = "Gl@bant12345!"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}

