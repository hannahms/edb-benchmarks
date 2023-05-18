# EDB Benchmarking Automation Center
## AWS PGBench Postgres

AWS PGBench Postgres is a project that provides benchmark data utilizing PGBench with Postgres on Amazon Web Services (AWS).

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

---

Deployment Ansible playbooks are available in the `ansible` directory. These
playbooks are designed to deploy one buildbot master noder and multiple buildbot
worker nodes.

Buildbot master and workers are executed through a dedicated Python virtual
environment.

The following components are installed on the workers:
- `ansible-core`
- `terraform`
- `edb-terraform`
- `edb-ansible`
- `biganimal`
- `tpaexec`

### Executing a benchmark

Execution of a benchmark is accomplished by following the steps below

- Clicking the `Builders` Link on the left hand navigation
- Filling all the parameters requested 
- Executing the `Start build`

### Notes:

These are the items to take into account should issues arise:

- Should an error within a step of the pipeline for a benchmark fail with an error similar to: "Cannot find the job". Take notice of the step in the workflow and the task. Once you have those items check to see if the `async` and `poll` are commented. **They are currently commented out because they were causing issues with the benchmark**



