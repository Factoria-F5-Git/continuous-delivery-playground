# Lab 4: Continuous integration - Step 2: Building and packaging the app

The goal of this lab is to show you how to add a stage in our pipeline to build and package the app.

> Note: this lab builds upon the results of the previous labs.

## Adding a build stage to our continuous deploy process

In the previous stage of our pipeline we make sure the latest changes are integrated and the test are passing. So we've already achieved continuous integration. To move forward with the continuous delivery, the next step is to build and package a new version of the application every time we push new code.

Lets add a new job call build with the following steps

```yaml
jobs:
    [...]
    build:
        name: Build
        needs: test
        runs-on: ubuntu-latest
        steps:
            - name: Checkout code
              uses: actions/checkout@v4
            - name: Setup Node.js ${{ env.NODE_VERSION }}
              uses: actions/setup-node@v4
              with:
                  node-version: ${{ env.NODE_VERSION }}
            - name: Build the application
              run: |
                npm ci
                npm run build
            - name: Upload artifacts
              uses: actions/upload-artifact@v4
              with:
                name: modern-web-app-v${{ github.sha }}
                path: modern-web-app/.next/

```

As you can see, we added a step to build the application and its dependecies with NPM. Finally, we use the upload-artifact GitHub Action to upload a build artifact into the GitHub server that contains a packaged version of the application.

> "Only build packages once. We want to be sure the thing we’re deploying is the same thing we’ve tested throughout the deployment pipeline, so if a deployment fails we can eliminate the packages as the source of the failure." -- by [continuousdelivery.com](https://continuousdelivery.com/implementing/patterns/)

### Pipeline Concepts
- **_needs_**: This step will not run unless the step defined here is successful.
- **_uses_**: To specify already defined GitHub Actions. You can think of these as reusable actions that you can incorporate in your pipeline, e.g. checkout, setup-node... 
For documentation and to find other actions you can go to the offical [GitHub marketplace](https://github.com/marketplace?type=actions). It's also good to check the documentation to get the newest version of the action. Some of the actions we've used here are: 
[setup-node-js](https://github.com/marketplace/actions/setup-node-js-environment)
[checkout](https://github.com/marketplace/actions/checkout)
- **_with_**: To pass the parameters to already defined GitHub Actions.

## Lab checklist

- [ ] Read the instructions
- [ ] Add the build job to the CD workflow
- [ ] Push the changes and check the pipeline logs in the Actions tab
- [ ] Think about other tasks that could be automated as part of the build stage in the pipeline
