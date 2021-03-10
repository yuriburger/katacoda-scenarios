Azure uses Service Plans to host our Azure Function. Let's also add this to the Terraform configuration:

<pre class="file" data-filename="main.tf" data-target="append">
resource "azurerm_app_service_plan" "appsp" {
  name = "${azurerm_resource_group.rg.name}funcappsp"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind = "FunctionApp"

  // Dynamic means Pay-per-Use
  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}
</pre>

And we add the Azure Function that retrieves and eventually runs the code from the Azure Storage Container:

<pre class="file" data-filename="main.tf" data-target="append">
resource "azurerm_function_app" "fa" {
  name = "${azurerm_resource_group.rg.name}func"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.appsp.id
  storage_account_name = azurerm_storage_account.sa.name
  storage_account_access_key = azurerm_storage_account.sa.primary_access_key
  version = "~3"
  https_only = true
  app_settings = {
    FUNCTIONS_WORKER_RUNTIME = "node"
    WEBSITE_NODE_DEFAULT_VERSION = "~10"
    FUNCTION_APP_EDIT_MODE = "readonly"
    HASH = base64encode(filesha256(data.archive_file.init.output_path))
    WEBSITE_RUN_FROM_PACKAGE = "https://${azurerm_storage_account.sa.name}.blob.core.windows.net/${azurerm_storage_container.sc.name}/${azurerm_storage_blob.appcode.name}${data.azurerm_storage_account_sas.sasfunc.sas}"
  }
  identity {
    type = "SystemAssigned"
  }
}
</pre>

Now we are ready to test our Terraform template, so let's head over to the final step!
