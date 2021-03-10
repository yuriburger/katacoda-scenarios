Switch back to your Terminal tab. Next thing we need to do, is login to the Azure Demo account (you will need enough permissions to create resources).

```
az login
```{{execute}}

If you have more than one tenant connected to your Azure account, make sure you select the correct one!

And we can ask Terraform to show us what will be created / modified. In our case... everything, since this is a new account.

```
cd tf_config
terraform init
terraform plan
```{{execute}}

If all goes as planned, we can apply the Terraform configuration:

```
terraform apply
```{{execute}}

This should now create all the needed parts, including our Azure Function!

If Terraform completes, we can test our function with this oneliner:

```
curl "$(func azure functionapp list-functions terraformfunc --show-keys | grep url | cut -f 11 -d " ")&name=World"
```{{execute}}

