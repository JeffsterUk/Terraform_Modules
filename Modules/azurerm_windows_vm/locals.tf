locals {
  image_list = {
    WindowsServer2022 = {
      "offer" : "WindowsServer",
      "publisher" : "MicrosoftWindowsServer",
      "sku" : "2022-Datacenter",
      "version" : "latest"
    },
    WindowsServer2019 = {
      "offer" : "WindowsServer",
      "publisher" : "MicrosoftWindowsServer",
      "sku" : "2019-Datacenter",
      "version" : "latest"
    },
    WindowsServer2016 = {
      "offer" : "WindowsServer",
      "publisher" : "MicrosoftWindowsServer",
      "sku" : "2016-Datacenter",
      "version" : "latest"
    },
    WindowsServer2012R2 = {
      "offer" : "WindowsServer",
      "publisher" : "MicrosoftWindowsServer",
      "sku" : "2012-R2-Datacenter",
      "version" : "latest"
    },
    WindowsServer2012 = {
      "offer" : "WindowsServer",
      "publisher" : "MicrosoftWindowsServer",
      "sku" : "2012-Datacenter",
      "version" : "latest"
    },
    WindowsServer2008R2-SP1 = {
      "offer" : "WindowsServer",
      "publisher" : "MicrosoftWindowsServer",
      "sku" : "2008-R2-SP1",
      "version" : "latest"
    }
  }

  source_image_reference = var.source_image_name == null ? var.source_image_reference : local.image_list[var.source_image_name]
}