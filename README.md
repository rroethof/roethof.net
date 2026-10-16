# roethof.net
My personal tech blog created with Hugo, using the blowfish theme. I aim for this project to follow open source best practices in its development and community engagement.

## Code of Conduct and Contributing

I believe in fostering a collaborative and open environment for everyone who interacts with my project. To that end, I have established a clear [Code of Conduct](CODE_OF_CONDUCT.md) that outlines my expectations for participant behavior in all project-related spaces. This Code of Conduct is inspired by the principles of open source collaboration and aims to create a positive and productive community for learning, sharing, and building together. I encourage everyone to review it.

I am also enthusiastic about community contributions! Whether you're looking to report a bug, suggest a new feature, improve the documentation, or contribute code, I appreciate your involvement. My [Contributing guidelines](CONTRIBUTING.md) provide detailed information on how you can get started and the processes I follow. I believe that collective effort and diverse perspectives are invaluable to the success of this project within a collaborative and open spirit.

For further insights into building healthy and collaborative open source communities and effective contribution practices, I recommend exploring the [Open Source Guides](https://opensource.guide/).

# GitHub Actions and Security Secrets
To run automated tasks and workflows in this repository, I use [GitHub Actions](https://github.com/features/actions). You can find more information about getting started with GitHub Actions in the [official documentation](https://help.github.com/en/actions/getting-started-with-github-actions). The use of automation and secure handling of sensitive information are important aspects of modern software development, as highlighted in resources like the [Open Source Guides](https://opensource.guide/).

To securely store sensitive information such as API keys and database credentials, I use [security secrets](https://docs.github.com/en/actions/security-security-secrets).
Secrets are stored securely on GitHub and can be accessed by my workflows. Understanding and utilizing these features contributes to a more secure and maintainable project.

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
| FTP_SERVER | variable | ftp.yourserver.tld |
| FTP_USERNAME | variable | username |
| FTP_WEBSITE | variable | domainname.tld |

For more insights into building and maintaining open source projects, including aspects like automation and security, I recommend exploring the [Open Source Guides](https://opensource.guide/).