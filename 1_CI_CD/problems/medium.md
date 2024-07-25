# Medium Problem: Integrating Linting and Code Coverage

## Task

Enhance the CI pipeline created in the easy problem by adding linting and code coverage checks.

## Steps

1. Extend your existing project to include a linter and a code coverage tool.
2. Update the GitHub Actions workflow to run the linter and code coverage checks in addition to the unit tests.
3. Ensure the workflow fails if linting errors are found or if the code coverage drops below a certain threshold.

### Example

For a Node.js project, you might:

1. Install ESLint for linting and Jest for testing with coverage.
2. Update the `package.json` scripts:

```json
"scripts": {
  "lint": "eslint .",
  "test": "jest --coverage"
}
```

3. Update the GitHub Actions workflow file:

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