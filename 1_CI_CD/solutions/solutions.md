# Solutions for CI/CD Problems

## Easy Problem Solution

### Steps

1. Created a new GitHub repository.
2. Added a simple Node.js project with a unit test.
3. Created a `.github/workflows` directory.
4. Created a `ci.yml` file inside the workflows directory.
5. Defined the workflow to check out the code, set up Node.js, install dependencies, and run tests.

### GitHub Actions Workflow File

```yaml
name: CI

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
    - name: Run tests
      run: npm test
```
## Medium Problem Solution

### Steps

1. Installed ESLint and Jest for the Node.js project.
2. Added lint and test scripts in package.json.
3. Updated the GitHub Actions workflow to include linting and code  coverage checks.

Updated GitHub Actions Workflow File

```yaml
name: CI

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
    - name: Run linter
      run: npm run lint
    - name: Run tests
      run: npm test
```
Hard Problem Solution
Steps

    Created a Node.js web application.
    Defined build and test scripts in package.json.
    Set up a GitHub Actions workflow to build, test, and deploy to AWS.

Updated GitHub Actions Workflow File

## Hard Problem Solution

### Steps

1. Created a Node.js web application.
2. Defined build and test scripts in `package.json`.
3. Set up a GitHub Actions workflow to build, test, and deploy to AWS.

### Updated GitHub Actions Workflow File

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

### Explanation

- **Easy Problem**: This problem introduces the basics of CI by setting up a workflow that runs unit tests on code pushes.
- **Medium Problem**: This problem builds on the easy problem by adding linting and code coverage checks, ensuring higher code quality.
- **Hard Problem**: This problem demonstrates a full CI/CD pipeline, including deployment to a cloud provider, showcasing how to integrate build, test, and deployment steps in a single automated workflow.
```