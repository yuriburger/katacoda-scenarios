We need a bit of Azure storage to be able to upload and deploy our function. Storage in Azure works by creating a Storage Account and a Storage Container.

Switch back to the IDE tab and add the following to our Terraform file to create the Storage Account:

<pre class="file" data-filename="main.tf" data-target="append">
resource "azurerm_storage_account" "sa" {
  name = "${azurerm_resource_group.rg.name}funcsa"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}
</pre>

And add a Storage Container to contain our packaged and released functions:

<pre class="file" data-filename="main.tf" data-target="append">
resource "azurerm_storage_container" "sc" {
  name = "function-releases"
  storage_account_name = azurerm_storage_account.sa.name
  container_access_type = "private"
}
</pre>

As we mentioned in a previous step, our function needs to be ZIPped and uploaded. For the ZIP part, we add a function to our file:

<pre class="file" data-filename="main.tf" data-target="append">
data "archive_file" "init" {
  type = "zip"
  source_dir = "../function_app"
  output_path = "../function_app/functions${formatdate("DDMMYY", timestamp())}.zip"
}
</pre>

In the next step we will configure the actual upload and continue on the rest of our deployment.
