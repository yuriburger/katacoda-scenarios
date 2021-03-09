# Terraform configuration

We start by creating a Terraform configuration file - `main.tf`{{open}}

And add a provider for Microsoft Azure

<pre class="file" data-filename="main.tf" data-target="copy">
provider "azurerm" {
 version = "=2.18.0"
 features {}
}
</pre>
