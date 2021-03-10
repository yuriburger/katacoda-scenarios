The ZIP file we created from our function needs to be uploaded. Terraform can copy the file to our storage container, we configure this with the following code added to our "main.tf":

<pre class="file" data-filename="main.tf" data-target="append">
resource "azurerm_storage_blob" "appcode" {
  name = "functionapp.zip"
  storage_account_name = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.sc.name
  type = "Block"
  source = data.archive_file.init.output_path
}
</pre>

Our Azure Storage Account is ofcourse not writable by the world, we need to provide a Shared Access Signature to securely access the function ZIP file from the Azure Function App. Add this block of code:

<pre class="file" data-filename="main.tf" data-target="append">
data "azurerm_storage_account_sas" "sasfunc" {
  connection_string = azurerm_storage_account.sa.primary_connection_string
  https_only = true
  start = "2020-01-01"
  expiry = "2021-12-31"
  resource_types {
    object = true
    container = false
    service = false
  }
  services {
    blob = true
    queue = false
    table = false
    file = false
  }
  permissions {
    read = true
    write = false
    delete = false
    list = false
    add = false
    create = false
    update = false
    process = false
  }
}
</pre>

In the next step we will configure our function app.
