# Easy Problem: Setting Up a Basic CI Pipeline

## Task

Set up a basic CI pipeline using GitHub Actions that runs unit tests on your project whenever there is a push to the main branch.

## Steps

1. Create a new GitHub repository.
2. Add a simple project with at least one unit test (can be in any language).
3. Create a `.github/workflows` directory.
4. Inside the workflows directory, create a YAML file for the GitHub Actions workflow.
5. Define a job that:
   - Checks out the code
   - Sets up the required environment (e.g., install dependencies)
   - Runs the unit tests
6. Commit and push the code to the main branch and verify that the workflow runs.

### Example

If you are using a Node.js project, your GitHub Actions workflow file might look like this:

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