# EDB Benchmarking Automation Center
## Welcome to the edb-benchmarks repository!

This repository contains workflows for benchmarks that have been previously developed and are ready for a pre-built execution via the Buildbot User Interface.

### Getting Started

To get started Buildbot master and workers are executed through a dedicated Python virtual
environment.

The following components are installed on the workers:
- `ansible-core`
- `terraform`
- `edb-terraform`
- `edb-ansible`
- `biganimal`
- `tpaexec`

Components needed by host:
- `terraform >= 1.3.6`
- `edb-terraform >= 1.0.0`
- `AWSCli`
- `ansible-core`
- `tpaexec`

### Executing a benchmark

Execution of a benchmark is accomplished by following the steps below

- Clicking the `Builders` Link on the left hand navigation
- Filling all the parameters requested 
- Executing the `Start build`

### Benchmark folder structure:

Each benchmark should follow the directory structure listed below:

- `validate` - Validates the parameters selected for the benchmark execution. **If the validation fails the entire benchmark fails.**
- `provision` - Provisions the infrastructure required for executing the benchmark
- `deploy` - Sets up and configures the provisioned infrastructure
- `prepare` - Prepares and sets up the benchmark execution
- `execute` - Executes the benchmark
- `push_results` - Upload the results from the benchmark into AWS S3 Bucket
- `unprovision` - Destroys the previously provisioned infrastructure

**Each directory contains a `run.sh` script file that executes the ansible playbooks required for the benchmark**

### Contributing:

We welcome contributions! If you have benchmarks that you would like to share follow the steps below:

- Simply fork this repository
- Add your benchmarks
- Submit a pull request. 

**Please ensure that the code is well-documented and follows our Guidelines below.**

### Guidelines:

When submitting benchmarks, please follow these guidelines:

- Use clear and concise names for the benchmark files and directories
- Include a `README.md` file in the main directory. The file content should explain: 
  - What the benchmark does
  - How to run it
  - Relevant details related to the benchmark
  - Make sure that the benchmarks are reproducible

### License

The license is available [here](LICENSE.md)
