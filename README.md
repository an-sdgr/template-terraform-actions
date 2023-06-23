# TFE actions template

This is a template for repositories connected to TFE,
using github actions to manage runs instead of the TFE VCS integration.

Links after 'Configure TFE' are populated by the 'Repo Setup' action.

The terraform included is for development only,
and will not create genuine resources.

[tfcoremock](https://github.com/hashicorp/terraform-provider-tfcoremock)
is included to allow modeling providers, without creating any resources.

This provider is extremely useful when testing CI, because it will produce a change every run.

See [Running Terraform in Automation](https://developer.hashicorp.com/terraform/tutorials/automation/automate-terraform)
and [Automate Terraform with GitHub Actions](https://developer.hashicorp.com/terraform/tutorials/automation/github-actions)
for more in-depth guidance.

The container image used is [hashicorp/tfci](https://github.com/hashicorp/tfc-workflows-tooling/blob/main/docs/USAGE.md)

## Usage

### Configure Repo

Use this repo as a template in github. After you create your repo, navigate to actions and run 'Repo Setup'.

You will need to provide:

- A workspace name
- A TFE organization
- A choice on where plan output is shown

The links in the "Usage" section will not work until this is done.

After you have done this, clone the repo locally and move the workflows to `.github/workflows`

```shell-session
cp workflows/* .github/workflows
rm -rf workflows
git add .github/workflows/*
git rm -r workflows
git commit -m 'setup workflows'
git push
```

You will see a failed actions run with the message `terraform cloud API token is not set`.

### Configure TFE

Create a [team in TFE](https://$TF_CLOUD_HOSTNAME/app/$TF_CLOUD_ORGANIZATION/settings/teams),
and name it something like $TF_WORKSPACE

Grant the team no org-level permissions, and generate a team token.

Create a [github secret](https://github.com/$OWNER/$TF_WORKSPACE/settings/secrets/actions) named `TF_API_TOKEN` with the value as your token.

Create a terraform workspace, and select "API-driven workflow".

[Grant](https://$TF_CLOUD_HOSTNAME/app/$TF_CLOUD_ORGANIZATION/workspaces/$TF_WORKSPACE/settings/access) the newly created team $TF_WORKSPACE admin on the workspace.

After this, your actions jobs will work properly on push and pull_request.

## Massive workspaces

From the [setup-terraform docs](https://github.com/hashicorp/setup-terraform#usage)

Notice: There's a limit to the number of characters inside a GitHub comment (65535).
Due to that limitation, you might end up with a failed workflow run even if the plan succeeded.

If you encounter this issue, see the linked documentation.

## Local development

### Act

[act](https://github.com/nektos/act) can be used to model github pipelines locally.

[install](https://github.com/nektos/act#installation-through-package-managers)

this error is normal:

```shell-session
[nason:~/src/template-terraform-actions] [default] main* ± act -l
WARN  ⚠ You are using Apple M-series chip and you have not specified container architecture, you might encounter issues while running act. If so, try running it with '--container-architecture linux/amd64'. ⚠  
```

You will need a [PAT](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens)

To easily get a PAT, I suggest installing the [github cli](https://cli.github.com/) and using `act -s GITHUB_TOKEN="$(gh auth token)"`

Docker is also required, which is outside the scope of this readme.

## Contributing

Feel free to send me a PR, generally I ask:

Run `terraform fmt` on terraform code.

Run `markdownlint` on Markdown.

Run `actionlint` on the actions files.
