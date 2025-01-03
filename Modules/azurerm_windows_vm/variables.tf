variable "network_interfaces" {
  type = list(object({
    name                          = string
    dns_servers                   = list(string)
    internal_dns_name_label       = string

    ip_configuration = list(object({
      name                                               = string
      gateway_load_balancer_frontend_ip_configuration_id = string
      subnet_id                                          = string
      private_ip_address_version                         = string
      private_ip_address_allocation                      = string
      public_ip_address_id                               = string
      primary                                            = string
      private_ip_address                                 = string
    }))
  }))

  description = <<-EOT
    A Virtual Machine needs one or more network cards so it can talk externally.

    The schema for network_interfaces is:
    ```
      [
        {
          name                          = string       - (Required) The name of the Network Interface. Changing this forces a new resource to be created.
          dns_servers                   = list(string) - (Optional) A list of IP Addresses defining the DNS Servers which should be used for this Network Interface.
          enable_ip_forwarding          = bool         - (Optional) Should IP Forwarding be enabled? Defaults to false.
          enable_accelerated_networking = bool         - (Optional) Should Accelerated Networking be enabled? Defaults to false.
          internal_dns_name_label       = string       - (Optional) The (relative) DNS Name used for internal communications between Virtual Machines in the same Virtual Network.

          ip_configuration = [ // Required - One or more ip_configuration blocks as defined below.
            {
              name                                               = string - (Required) A name used for this IP Configuration.
              gateway_load_balancer_frontend_ip_configuration_id = string - (Optional) The Frontend IP Configuration ID of a Gateway Sku Load Balancer.
              subnet_id                                          = string - (Optional) The ID of the Subnet where this Network Interface should be located in. This is required when private_ip_address_version is set to IPv4.
              private_ip_address_version                         = string - (Optional) The IP Version to use. Possible values are IPv4 or IPv6. Defaults to IPv4.
              private_ip_address_allocation                      = string - (Required) The allocation method used for the Private IP Address. Possible values are Dynamic and Static.
              public_ip_address_id                               = string - (Optional) Reference to a Public IP Address to associate with this NIC
              primary                                            = string - (Optional) Is this the Primary IP Configuration? Must be true for the first ip_configuration when multiple are specified. Defaults to false.
              private_ip_address                                 = string - (Optional) The Static IP Address which should be used.
            }
          ]
        }
      ]
    ```
    **NOTE1**: If a property isn't required then it must be explicitly set as an empty list or null.

    **NOTE2**: Configuring DNS Servers on the Network Interface will override the DNS Servers defined on the Virtual Network.

    **NOTE3**: Only certain Virtual Machine sizes are supported for Accelerated Networking - [more information can be found in this document](https://docs.microsoft.com/en-us/azure/virtual-network/create-vm-accelerated-networking-cli).
  EOT
}

variable "name" {
  type        = string
  description = "The name of the Windows Virtual Machine. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group in which the Windows Virtual Machine should be exist. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "The Azure location where the Windows Virtual Machine should exist. Changing this forces a new resource to be created."
}

variable "size" {
  type        = string
  description = "The SKU which should be used for this Virtual Machine, such as `Standard_F2`."
}

variable "admin_username" {
  type        = string
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "allow_extension_operations" {
  type        = bool
  description = "Should Extension Operations be allowed on this Virtual Machine?"
  default     = true
}

variable "availability_set_id" {
  type        = string
  description = "Specifies the ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "computer_name" {
  type        = string
  description = "Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the `name` field. If the value of the `name` field is not a valid `computer_name`, then you must specify `computer_name`. Changing this forces a new resource to be created."
  default     = null
}

variable "custom_data" {
  type        = string
  description = "The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created."
  default     = null
}

variable "dedicated_host_id" {
  type        = string
  description = "The ID of a Dedicated Host where this machine should be run on."
  default     = null
}

variable "enable_automatic_updates" {
  type        = bool
  description = "Specifies if Automatic Updates are Enabled for the Windows Virtual Machine. Changing this forces a new resource to be created."
  default     = true
}

variable "encryption_at_host_enabled" {
  type        = bool
  description = "Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
  default     = null
}

variable "eviction_policy" {
  type        = string
  description = "Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. At this time the only supported value is `Deallocate`. Changing this forces a new resource to be created."
  default     = null
}

variable "extensions_time_budget" {
  type        = string
  description = "Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to 90 minutes."
  default     = "PT1H30M"
}

variable "license_type" {
  type        = string
  description = "Specifies the type of on-premise license (also known as Azure Hybrid Use Benefit) which should be used for this Virtual Machine. Possible values are `None`, `Windows_Client` and `Windows_Server`."
  default     = "None"
}

variable "max_bid_price" {
  type        = number
  description = "The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction_policy. Defaults to -1, which means that the Virtual Machine should not be evicted for price reasons. This can only be configured when priority is set to `Spot`."
  default     = -1
}

variable "patch_mode" {
  type        = string
  description = "Specifies the mode of in-guest patching to this Windows Virtual Machine. Possible values are `Manual`, `AutomaticByOS` and `AutomaticByPlatform`. This is a preview feature, you can opt-in with the command `az feature register -n InGuestAutoPatchVMPreview --namespace Microsoft.Compute.`"
  default     = "AutomaticByOS"
}

variable "patch_assessment_mode" {
  type        = string
  description = "Specifies the mode of in-guest patch assessment to this Windows Virtual Machine. Possible values are `ImageDefault`, `ImageOnly`, `AutomaticByOS` and `AutomaticByPlatform`. This is a preview feature, you can opt-in with the command `az feature register -n InGuestAutoPatchVMPreview --namespace Microsoft.Compute.`"
  default     = "ImageDefault"
}

variable "platform_fault_domain" {
  type        = number
  description = "Specifies the Platform Fault Domain in which this Windows Virtual Machine should be created. If not provided, this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Windows Virtual Machine to be created."
  default     = null
}

variable "priority" {
  type        = string
  description = "Specifies the priority of this Virtual Machine. Possible values are `Regular` and `Spot`. Changing this forces a new resource to be created."
  default     = "Regular"
}

variable "provision_vm_agent" {
  type        = bool
  description = "Should the Azure VM Agent be provisioned on this Virtual Machine? Changing this forces a new resource to be created."
  default     = true
}

variable "proximity_placement_group_id" {
  type        = string
  description = "The ID of the Proximity Placement Group which the Virtual Machine should be assigned to."
  default     = null
}

variable "source_image_id" {
  type        = string
  description = "The ID of the Image which this Virtual Machine should be created from. Changing this forces a new resource to be created."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "timezone" {
  type        = string
  description = "Specifies the Time Zone which should be used by the Virtual Machine, [the possible values are defined here](https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/)."
  default     = null
}

variable "virtual_machine_scale_set_id" {
  type        = string
  description = "Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within. Changing this forces a new resource to be created."
  default     = null
}

variable "zone" {
  type        = string
  description = "The Zone in which this Virtual Machine should be created. Changing this forces a new resource to be created."
  default     = null
}

variable "os_disk_caching" {
  type        = string
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite."
}

variable "os_disk_storage_account_type" {
  type        = string
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values are `Standard_LRS`, `StandardSSD_LRS` and `Premium_LRS`. Changing this forces a new resource to be created."
}

variable "os_disk_encryption_set_id" {
  type        = string
  description = "The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. The Disk Encryption Set must have the Reader Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault."
  default     = null
}

variable "os_disk_size_gb" {
  type        = string
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. If specified this must be equal to or larger than the size of the Image the Virtual Machine is based on. When creating a larger disk than exists in the image you'll need to repartition the disk to use the remaining space."
  default     = null
}

variable "os_disk_name" {
  type        = string
  description = "The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created."
  default     = null
}

variable "os_disk_write_accelerator_enable" {
  type        = bool
  description = "Should Write Accelerator be Enabled for this OS Disk?"
  default     = false
}

variable "os_disk_diff_disk_settings" {
  type = object({
    option = string
  })

  description = <<-EOT
    A os_disk_diff_disk_settings block as defined :
    ```
    {
      option = string - (Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is `Local`. Changing this forces a new resource to be created.
    }
    ```
  EOT

  default = null
}

variable "additional_capabilities" {
  type = object({
    ultra_ssd_enabled = string
  })

  description = <<-EOT
    A additional_capabilities block as defined below:
    ```
    {
      ultra_ssd_enabled = string - (Optional) Should the capacity to enable Data Disks of the `UltraSSD_LRS` storage account type be supported on this Virtual Machine? Defaults to `false`.
    }
    ```
  EOT

  default = null
}

variable "additional_unattend_content" {
  type = list(object({
    content = string
    setting = string
  }))

  description = <<-EOT
    One or more additional_unattend_content blocks as defined below:
    ```
    [
      {
        content = string - (Required) The XML formatted content that is added to the unattend.xml file for the specified path and component. Changing this forces a new resource to be created.
        setting = string - (Required) The name of the setting to which the content applies. Possible values are `AutoLogon` and `FirstLogonCommands`. Changing this forces a new resource to be created.
      }
    ]

    ```
  EOT

  default = []
}

variable "boot_diagnostics" {
  type = object({
    storage_account_uri = string
  })

  description = <<-EOT
    A boot_diagnostics block supports the following:
    ```
    {
      storage_account_uri = string - (Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor.
    }
    ```

    **NOTE**: Passing a null value will utilize a Managed Storage Account to store Boot Diagnostics.
  EOT

  default = {
    storage_account_uri = null
  }
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = list(string)
  })

  description = <<-EOT
    An identity block as defined below:
    ```
    {
      type         = string       - (Required) The type of Managed Identity which should be assigned to the Windows Virtual Machine. Possible values are SystemAssigned, UserAssigned and SystemAssigned, UserAssigned.
      identity_ids = list(string) - (Optional) A list of User Managed Identity ID's which should be assigned to the Windows Virtual Machine. This is required when type is set to UserAssigned.
    }
    ```

    **NOTE**: If a property isn't required then it must be explicitly set as an empty list or null.
  EOT

  default = null
}

variable "plan" {
  type = object({
    name      = string
    product   = string
    publisher = string
  })

  description = <<-EOT
    A plan block supports the following:
    ```
    {
      name      = string - (Required) Specifies the Name of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
      product   = string - (Required) Specifies the Product of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
      publisher = string - (Required) Specifies the Publisher of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
    }
    ```
  EOT

  default = null
}

variable "secret" {
  type = list(object({
    key_vault_id = string

    certificate = list(object({
      store = string
      url   = string
    }))
  }))

  description = <<-EOT
    A secret block supports the following:
    ```
    [
      {
        key_vault_id = string - (Required) The ID of the Key Vault from which all Secrets should be sourced.

        certificate = [ // (Required) One or more certificate blocks as defined.
          {
            store = string - (Required) The certificate store on the Virtual Machine where the certificate should be added.
            url   = string - (Required) The Secret URL of a Key Vault Certificate. This can be sourced from the secret_id field within the azurerm_key_vault_certificate Resource.
          }
        ]
      }
    ]
    ```
  EOT

  default = []
}

variable "source_image_name" {
  type        = string
  description = "Can be used as an alternative to providing a value for `source_image_reference`. It is a variable for convenience and picks the latest patched Datacenter version of the chosen OS image. Possible values are `WindowsServer2008R2`, `WindowsServer2012`, `WindowsServer2012R2`, `WindowsServer2016`, `WindowsServer2019` and `WindowsServer2022`."
  default     = null

  validation {
    condition     = var.source_image_name == null ? true : contains(["WindowsServer2008R2", "WindowsServer2012", "WindowsServer2012R2", "WindowsServer2016", "WindowsServer2019", "WindowsServer2022"], var.source_image_name)
    error_message = "Variable source_image_name needs to be a value of WindowsServer2008R2, WindowsServer2012, WindowsServer2012R2, WindowsServer2016, WindowsServer2019 or WindowsServer2022. Provided value is not valid."
  }
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })

  description = <<-EOT
    source_image_reference supports the following:
    ```
    {
      publisher = string - (Optional) Specifies the publisher of the image used to create the virtual machines.
      offer     = string - (Optional) Specifies the offer of the image used to create the virtual machines.
      sku       = string - (Optional) Specifies the SKU of the image used to create the virtual machines.
      version   = string - (Optional) Specifies the version of the image used to create the virtual machines.
    }
    ```
    
    **NOTE1**: if `source_image_name` is provided then the value provided for `source_image_reference` is ignored.

    **NOTE2**: If a property isn't required then it must be explicitly set as an empty list or null.
  EOT

  default = null
}

variable "winrm_listener" {
  type = list(object({
    protocol        = string
    certificate_url = string
  }))

  description = <<-EOT
    A winrm_listener block supports the following:
    ```
    protocol        = string - (Required) Specifies Specifies the protocol of listener. Possible values are Http or Https
    certificate_url = string - (Optional) The Secret URL of a Key Vault Certificate, which must be specified when protocol is set to Https.
    ```

    **NOTE**: If a property isn't required then it must be explicitly set as an empty list or null.
  EOT

  default = []
}

variable "additional_managed_disks" {
  type = list(object({
    name                          = string
    storage_account_type          = string
    create_option                 = string
    disk_encryption_set_id        = string
    disk_iops_read_write          = string
    disk_mbps_read_write          = string
    disk_iops_read_only           = string
    disk_size_gb                  = string
    image_reference_id            = string
    logical_sector_size           = string
    os_type                       = string
    source_resource_id            = string
    source_uri                    = string
    storage_account_id            = string
    tier                          = string
    max_shares                    = string
    trusted_launch_enabled        = string
    on_demand_bursting_enabled    = string
    zones                         = list(string)
    network_access_policy         = string
    disk_access_id                = string
    public_network_access_enabled = string
    lun                           = string
    caching                       = string
    write_accelerator_enabled     = bool

    encryption_settings = object({
      disk_encryption_key = object({
        secret_url      = string
        source_vault_id = string
      })

      key_encryption_key = object({
        key_url         = string
        source_vault_id = string
      })
    })

  }))

  description = <<-EOT
    A list of additional disks with properties. This will create and attach to the virtual machine but not format the drives to a drive letter. This will need to be done through configuration management.
    
    The schema is below:
    ```
    [
      {
        name                          = string       - (Required) Specifies the name of the Managed Disk. Changing this forces a new resource to be created.
        storage_account_type          = string       - (Required) The name of the Resource Group where the Managed Disk should exist.
        create_option                 = string       - (Required) The method to use when creating the managed disk. Changing this forces a new resource to be created. See NOTE2 below for possible values
        disk_encryption_set_id        = string       - (Optional) The ID of a Disk Encryption Set which should be used to encrypt this Managed Disk. The Disk Encryption Set must have the Reader Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault. Disk Encryption Sets are in Public Preview in a limited set of regions.
        disk_iops_read_write          = string       - (Optional) The number of IOPS allowed for this disk; only settable for UltraSSD disks. One operation can transfer between 4k and 256k bytes.
        disk_mbps_read_write          = string       - (Optional) The bandwidth allowed for this disk; only settable for UltraSSD disks. MBps means millions of bytes per second.
        disk_iops_read_only           = string       - (Optional) (Optional) The number of IOPS allowed across all VMs mounting the shared disk as read-only; only settable for UltraSSD disks with shared disk enabled. One operation can transfer between 4k and 256k bytes.
        disk_size_gb                  = string       - (Optional, Required for a new managed disk. Specifies the size of the managed disk to create in gigabytes. If create_option is Copy or FromImage, then the value must be equal to or greater than the source's size. The size can only be increased.
        image_reference_id            = string       - (Optional) ID of an existing platform/marketplace disk image to copy when create_option is FromImage.
        logical_sector_size           = string       - (Optional) Logical Sector Size. Possible values are: 512 and 4096. Defaults to 4096. Changing this forces a new resource to be created.
        os_type                       = string       - (Optional) Specify a value when the source of an Import or Copy operation targets a source that contains an operating system. Valid values are Linux or Windows.
        source_resource_id            = string       - (Optional) The ID of an existing Managed Disk to copy create_option is Copy or the recovery point to restore when create_option is Restore
        source_uri                    = string       - (Optional) URI to a valid VHD file to be used when create_option is Import.
        storage_account_id            = string       - (Optional) The ID of the Storage Account where the source_uri is located. Required when create_option is set to Import. Changing this forces a new resource to be created.
        tier                          = string       - (Optional) The disk performance tier to use. Possible values are documented here. This feature is currently supported only for premium SSDs.
        max_shares                    = string       - (Optional) The maximum number of VMs that can attach to the disk at the same time. Value greater than one indicates a disk that can be mounted on multiple VMs at the same time. Premium SSD maxShares limit: P15 and P20 disks: 2. P30,P40,P50 disks: 5. P60,P70,P80 disks: 10. For ultra disks the max_shares minimum value is 1 and the maximum is 5.
        trusted_launch_enabled        = string       - (Optional) Specifies if Trusted Launch is enabled for the Managed Disk. Defaults to false.
        on_demand_bursting_enabled    = string       - (Optional) Specifies if On-Demand Bursting is enabled for the Managed Disk. Defaults to false.
        zones                         = list(string) - (Optional) A collection containing the availability zone to allocate the Managed Disk in.
        network_access_policy         = string       - (Optional) Policy for accessing the disk via network. Allowed values are AllowAll, AllowPrivate, and DenyAll.
        disk_access_id                = string       - (Optional) The ID of the disk access resource for using private endpoints on disks.
        public_network_access_enabled = string       - (Optional) Whether it is allowed to access the disk via public network. Defaults to true.
        lun                           = string       - (Required) The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine. Changing this forces a new resource to be created.
        caching                       = string       - (Required) Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite.
        write_accelerator_enabled     = bool         - (Optional) Specifies if Write Accelerator is enabled on the disk. This can only be enabled on Premium_LRS managed disks with no caching and M-Series VMs. Defaults to false.
      }
    ]
    ```

    **NOTE1**: If a property isn't required then it must be explicitly set as an empty list or null.

    **NOTE2**: Possible values for `create_option` include:
    - Import - Import a VHD file in to the managed disk (VHD specified with source_uri).
    - Empty - Create an empty managed disk.
    - Copy - Copy an existing managed disk or snapshot (specified with source_resource_id).
    - FromImage - Copy a Platform Image (specified with image_reference_id)
    - Restore - Set by Azure Backup or Site Recovery on a restored disk (specified with source_resource_id).

  EOT

  default = []
}

variable "key_vault_id" {
  type        = string
  description = "The ID of the Key Vault which should be used to store the VM Password."
}