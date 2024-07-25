# Advanced Deployment Strategies - Recreate Strategy

## Detailed Explanation

The Recreate Deployment Strategy is a straightforward approach to deploying new versions of an application where the existing version is completely shut down before deploying the new version. This strategy involves stopping the current version of the application, deploying the new version, and then starting it.

### Key Concepts

- **Shutdown**: The existing version of the application is stopped entirely before the new version is deployed.
- **Deployment**: The new version of the application is deployed to the environment.
- **Startup**: Once the deployment is complete, the new version is started and begins serving user requests.

### Advantages

- **Simplicity**: The recreate strategy is simple to implement and understand, making it easy to manage.
- **Consistency**: Ensures that all users experience the same version of the application, reducing potential inconsistencies.

### Disadvantages

- **Downtime**: Users experience downtime during the transition period when the application is being shut down and the new version is being deployed.
- **No Rolling Back**: If issues are encountered with the new version, reverting to the previous version requires a complete redeployment, which can be time-consuming and disruptive.

## Resources

- [Recreate Strategy Explained by AWS](https://aws.amazon.com/blue-green-deployment/)
- [Recreate Deployment Strategy by Google Cloud](https://cloud.google.com/compute/docs/instances/recreate-deployment)
- [Recreate Strategy Overview by Martin Fowler](https://martinfowler.com/bliki/RecreateDeployment.html)

## Real-Life Example

### Use Case: Simple Web Application Update

A small business with a web application wants to deploy a new version with several bug fixes and new features. Due to its simplicity and low traffic, they choose the Recreate Strategy for the deployment.

1. **Shutdown**:
   - The existing version of the web application is stopped. Users are temporarily unable to access the application during this time.
2. **Deployment**:
   - The new version of the application is deployed to the environment. This involves copying the new code and configurations to the servers.
3. **Startup**:
   - The new version is started, and the application begins accepting user requests again.
   - The deployment team monitors the application to ensure it operates correctly and meets the expected performance criteria.

## Graphics

### Recreate Deployment Diagram

![Recreate Deployment Diagram](https://miro.medium.com/v2/resize:fit:1200/format:webp/1*3N9h8w3EOl8fdwfy89Y3dA.png)

*Source: [Recreate Deployment Diagram](https://medium.com/@peterj.owen/blue-green-and-canary-deployment-strategies-d7f7e09f4a78)*

### Recreate Strategy Workflow

![Recreate Strategy Workflow](https://www.coursera.org/learn/continuous-deployment/home/resources)

*Source: [Recreate Strategy Workflow](https://www.coursera.org/learn/continuous-deployment/home/resources)*