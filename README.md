# Deploy Terraform resources to AWS using GitHub Actions via OIDC

The repo is used for demonstrating the setup that deploy AWS resources using GitHub Actions workflow via OIDC.

## Prerequisites

- An AWS account with permission to create OIDC identity provider, role, attach policy in AWS IAM service.
- An GitHub account to create a repository and workflows.

## References

[Use IAM roles to connect GitHub Actions to actions in AWS](https://aws.amazon.com/blogs/security/use-iam-roles-to-connect-github-actions-to-actions-in-aws/)
[Configuring OpenID Connect in Amazon Web Services](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
[](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-amazon-web-services)
[Identity providers and federation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers.html)
[OIDC federation](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_oidc.html)
