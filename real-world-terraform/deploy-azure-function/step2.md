In this step we need to create the actual function. Let's switch to our Terminal tab and create a directory for our function first:

```
cd deploy-azure-function
mkdir function_app
cd function_app
```{{execute}}

And initialize a simple function we can use as a skeleton project for more advanced operations:

```
func init --worker-runtime typescript
func new --language typescript --template "HTTP trigger" -n "hello_world_http"
npm install
npm run build
cd ..
```{{execute}}

Now that our function is ready, we can add it to our Terraform script in the next step.
