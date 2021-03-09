Terraform allows us to declare an infrastructure in a cloud-agnostic way. This means, that it is designed without a specific cloud vendor in mind. To deploy our function to a certain type of cloud (i.e. Microsoft Azure, Amazon Web Services, Google Cloud Platform) we need to start our configuration with specifying which cloud vendor to target:

# Setup

We start by creating a Terraform configuration file - `main.tf`{{open}}

And add a provider for Microsoft Azure:

<pre class="file" data-filename="main.tf" data-target="copy">
provider "azurerm" {
 version = "=2.18.0"
 features {}
}
</pre>

Since our function needs to be packed before uploading, we add a ZIP provider to our configuration:

<pre class="file" data-filename="main.tf" data-target="append">
provider "archive" {
 version = "~> 1.3"
}
</pre>

Azure uses Resource Groups to group our components, so we need to add a Terraform resource for that:

<pre class="file" data-filename="main.tf" data-target="append">
resource "azurerm_resource_group" "rg" {
 name = "terraform"
 location = "West Europe"
}
</pre>

This completes the setup and we can continue to the next step.
