Terraform allows us to declare an infrastructure in a cloud-agnostic way. This means, that it is designed without a specific cloud vendor in mind. To deploy our function to a certain type of cloud (i.e. Microsoft Azure, Amazon Web Services, Google Cloud Platform) we need to start our configuration by specifying which cloud vendor to target:

# Setup

We kick-off with creating a Terraform configuration file. Switch to your IDE tab and create a new file "main.tf" or click this link: `main.tf`{{open}}

The very first thing we do is.... add a provider for Microsoft Azure (and one for ZIP support, we will need it later):

<pre class="file" data-filename="main.tf" data-target="copy">
terraform {
  required_providers {
    azurerm = {
        version = "=2.18.0"
    }
    archive = {
        version = "~> 1.3"
    }
  }
}

provider "azurerm" {
  features {}
}
</pre>

Azure uses Resource Groups to group our components, so we also add a Terraform resource for that:

<pre class="file" data-filename="main.tf" data-target="append">
resource "azurerm_resource_group" "rg" {
  name = "terraform"
  location = "West Europe"
}
</pre>

This completes the setup and we can continue to the next step.
