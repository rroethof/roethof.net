# roethof.net
My personal tech blog created with Hugo, using the blowfish theme

# GitHub Actions and Security Secrets
To run automated tasks and workflows in our repository, we use [GitHub Actions](https://github.com/features/actions). You can find more information about getting started with GitHub Actions in the [official documentation](https://help.github.com/en/actions/getting-started-with-github-actions).
To securely store sensitive information such as API keys and database credentials, we use [security secrets](https://docs.github.com/en/actions/security-security-secrets). 
Secrets are stored securely on GitHub and can be accessed by your workflows. 

To learn more about creating and using security secrets in GitHub Actions, check out the official documentation:
* [Creating a new secret](https://help.github.com/en/actions/reference/creating-a-secret)
* [Using a secret in a workflow](https://help.github.com/en/actions/using-gh-actions/workflow-syntax-for-github-workflow)

You can find more information about GitHub Actions and security secrets by following these links:
* [GitHub Actions documentation](https://docs.github.com/en/actions)
* [Security Secrets documentation](https://docs.github.com/en/actions/reference/security-secrets)

## Required secrets / variables for our Github actions

| Name | Type | Our value |
|------|------|-----------|
| FIREBASE_APIKEY | secret | -- |
| FIREBASE_APPID | secret | -- |
| FIREBASE_AUTHDOMAIN | secret | -- |
| FIREBASE_MEASUREMENTID | secret | -- |
| FIREBASE_MESSAGINGSENDERID | secret | -- |
| FIREBASE_PROJECTID | secret | -- |
| FIREBASE_STORAGEBUCKET | secret | -- |
| FTP_PASSWORD | secret | -- |
| FTP_PORT | variable | 22 |
| FTP_SERVER | variable | ftp.ourserver.tld |
| FTP_USERNAME | variable | username |
| FTP_WEBSITE | variable | domainname.tld |
