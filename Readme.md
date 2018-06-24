## Appium Android in Docker

### Motivation
Goals of automated testing:
- fast
- reproducable results

### Approaches
- parallelisation of tests
- making sure, tests always run in the same, clean environment

### Solution
Introducing `Docker`, allows setting up a test image with a clean environment which then can be 
spinned up for each test run. A new test run results in a new container. Therefore the test 
environment is always the same.

Having test running in containers capsulates them from the host OS, which makes it possible to spin 
up multiple test containers which all run tests on e.g. different target device configurations. 
This allows parallelisation of tests.

### Requirements for docker containers
- as small as possible
    - use small base image
    - only install required software
- as transparent as needed
    - allow access to logs
    - allow live video streaming of tests
    - allow saving video / images of tests