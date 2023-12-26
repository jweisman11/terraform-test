### Learning Terraform

Goal is to create an API Gateway with multiple endpoints that proxy Lambda functions

### Learning Notes

- Terraform does not ascribe any special meaning to which filenames you use and how many files you have. Terraform instead reads all of the .tf files and considers their contents together.

- Need to re-run `terraform init` after adding a new module or changing a module name

- `terraform fmt` only works in the current directory. To get all files, use `terraform fmt --recursive`

-
