# Evaluating Terraform on IBM Cloud
This repository contains demo code for deploying infrastructure on ibm cloud via terraform (iaas).

![IBM Cloud Reference Architecture](https://1.cms.s81c.com/sites/default/files/2021-07-28/secure-roks-cluster.jpg)

## Objective
This demo aims at creating an infrastructure for an application that may access data on a storage account. 

* VPC as private networking environment
* KMS (unfortunately not available within free tier)
* Object storage as the blob storage including monitoring

## Prerequisites
Create a *.tfvars file and fill the variables according to:
* IBM cloud API key
* Select and define the region for the deployment

