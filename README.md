**This repository helps to setup a demo to pull secrets from conjur**

Pre-requisites:
- Access to Conjur Cloud with Admin privileges
- Conjurcli installed and reachable to conjur cloud
- Steps to setup conjurcli: https://docs.cyberark.com/conjur-cloud/latest/en/content/conjurcloud/cli/cli-setup.htm?Highlight=conjurcli
- Oficial Documentation: https://docs.cyberark.com/conjur-cloud/latest/en/content/integrations/github-actions.htm#tabset-2-tab-2

**1. Create the authentication webservice for Github Actions and set values**

      conjur policy load -f github-authn.yaml -b conjur/authn-jwt
        
  >{ "created_roles": {}, "version": xx }

**Set the values of authentication service configuration/vairables:**

      conjur variable set -i conjur/authn-jwt/github/jwks-uri -v https://token.actions.githubusercontent.com/.well-known/jwks
  
  >Result: Successfully set value for variable 'conjur/authn-jwt/github/jwks-uri'
  
      conjur variable set -i conjur/authn-jwt/github/issuer -v https://token.actions.githubusercontent.com
  
  >Result: Successfully set value for variable 'conjur/authn-jwt/github/issuer'
  
        conjur variable set -i conjur/authn-jwt/github/token-app-property -v "sub"
  
  >Result: Successfully set value for variable 'conjur/authn-jwt/github/token-app-property'
  
        conjur variable set -i conjur/authn-jwt/github/identity-path -v "data/github-apps"
  
  >Result: Successfully set value for variable 'conjur/authn-jwt/github/identity-path'
  
        conjur variable set -i conjur/authn-jwt/github/enforced-claims -v "repository,ref"
  
  >Result: Successfully set value for variable 'conjur/authn-jwt/github/enforced-claims'

Enable the authenticator service

      conjur authenticator enable --id authn-jwt/github

**2. Create the group and host ID for github actions and grant access to webservice from step 1**

```conjur policy load -f hosts-github.yaml -b data```

>{ "created_roles": {}, "version": xx }

```conjur policy load -f grant-host-authn-apps.yaml -b conjur/authn-jwt/github```

>{ "created_roles": {}, "version": xx }

**3. Grant access to safes/secrets for github Hosts**

```conjur policy load -f grant-secret-access.yaml -b data```

>{ "created_roles": {}, "version": xx }
