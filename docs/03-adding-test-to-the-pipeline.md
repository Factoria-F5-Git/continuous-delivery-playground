# Lab 3: Continuous integration - Step 1: Running the tests

The goal of this lab is to create the first stage in our CD pipeline, the test step. We will use what we learnt in lab 2 and replace our hello world pipeline for something more useful.

## Adding Test step to our CI

Given that our application code is not in the root folder, we need to tell GitHub Actions where to run the commands from. Lets specify that the NPM commands needs to be run from the modern-web-app directory. Lets add to our `pipeline.yml` the following:

```yml
defaults:
  run:
    working-directory: modern-web-app
```

We also need to tell one of the GitHub Actions which version of Node.js we need. First run `node --version` in your terminal and then add the version as an environment variable:

```yml
env:
  NODE_VERSION: "21.6.2"
```

The next step is to simply specify the test job and add it to the pipeline definition (`pipeline.yml`):

```yml
on: push

env: 
  ...

defaults:
  ...

jobs:
  test:
    name: Test
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Setup Node.js ${{ env.NODE_VERSION }}
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
      - name: Run unit tests
        run: |
          npm ci
          npm run test:unit
```

## Test gate keeping
Now we will see what happens if we add a dummy step after the test and we purposely make the test fail.

We will readd the Hello World step, after test:

```yml
jobs:
  test:
    [...]
    steps:
      [...]
      - name: Hello World step
        run: |
          echo "Hello World!"
```

And then we will add a the test to make it break:

```tsx
it('Zero is not equal to One', () => {
    expect(1).toBe(0)
  })
```

What happened now? Why did the Hello World step didn't run? What has to change so the step after test runs?

### Bonus - snapshot testing
If you go to the file `snapshot.tsx` you'll see we are testing a snapshot of our app. This means that if we change html of the application without updating the current snapshot, the test will fail. So if you want to play around with changing the visual part, after that use `jest --updateSnapshot` to update the current snapshot and that will avoid the test failing.

### Pipeline Concepts

- **_env_**: To specify environment variables that can be reused across the pipeline definition.
- **_working-directory_**: To change the directory from which GitHub Actions will execute the run commands
- **_uses_**: To sepecify already defined GitHub Actions. You can think of these as reusable actions that you can incorporate in your pipeline, e.g. checkout, setup-node... 
For documentation and to find other actions you can go to the offical [GitHub marketplace](https://github.com/marketplace?type=actions). It's also good to check the documentation to get the newest version of the action. Some of the actions we've used here are: 
[setup-node-js](https://github.com/marketplace/actions/setup-node-js-environment)
[checkout](https://github.com/marketplace/actions/checkout)
- **_with_**: To pass the parameters to already defined GitHub Actions.

### Let's test our new pipeline stage

Once the changes are commited and pushed, the pipeline should run automatically.

```bash
git add .
git commit -m "Add test stage to the CI pipeline"
git push
```

## Useful Theory

[What is continuous testing?](https://continuousdelivery.com/foundations/test-automation/)
Continuous testing is the practice of running many different types of tests—both manual and automated—continually throughout the delivery process with the goal of finding problems as soon as possible.

[What is test automation?](https://www.atlassian.com/devops/devops-tools/test-automation)
Test automation is the practices of automating test tasks to make sure the application is ready to be deployed and it meets the pre-defined quality standards.

## Lab checklist

- [ ] Read the instructions
- [ ] Replace the hello world job with the new test job
- [ ] Push the changes and check the pipeline execution in the Actions tab
- [ ] Break the tests, commit and push the changes. Check what happens.
