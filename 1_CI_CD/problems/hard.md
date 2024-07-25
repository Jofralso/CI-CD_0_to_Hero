# Hard Problem: Implementing a Full CI/CD Pipeline

## Task

Create a full CI/CD pipeline that includes building, testing, and deploying a web application. Use a cloud provider (e.g., AWS, Azure, GCP) for deployment.

## Steps

1. Create a simple web application.
2. Set up a GitHub Actions workflow that:
   - Builds the application
   - Runs unit and integration tests
   - Deploys the application to a cloud provider when code is pushed to the main branch
3. Ensure the deployment step only runs if all previous steps succeed.
4. Use appropriate secrets management for cloud provider credentials.

### Example

For an example Node.js web application deployed to AWS:

1. Define the `package.json` build script:

```json
"scripts": {
  "build": "webpack --config webpack.config.js",
  "test": "jest"
}
```

2. Update the GitHub Actions workflow file:
```yaml
name: CI/CD

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v2
    - name: Set up Node.js
      uses: actions/setup-node@v2
      with:
        node-version: '14'
    - name: Install dependencies
      run: npm install
    - name: Build the application
      run: npm run build
    - name: Run tests
      run: npm test

  deploy:
    runs-on: ubuntu-latest
    needs: build

    steps:
    - uses: actions/checkout@v2
    - name: Deploy to AWS
      env:
        AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
        AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      run: |
        aws s3 sync build/ s3://my-bucket --delete
        aws cloudfront create-invalidation --distribution-id YOUR_DISTRIBUTION_ID --paths "/*"
```