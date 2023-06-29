HammerDB TPROC-C workload with EPAS in Oracle Compatibility Mode on AWS EC2

This is a 2-tier test running a TPC-C-like workload using Oracle stored
procedures, almost exactly as they are for Oracle.

Environment variables:

- TERRAFORM_PROJECT_PATH - Absolute path to the terraform project
  created by edb-terraform.
- TPROCC_DURATION - Duration in minutes execution.
- TPROCC_VUSERS - Number of virtual users.
- TPROCC_WAREHOUSE - Number of warehouses.
