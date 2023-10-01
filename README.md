# caldera-splunk-lab

This lab environment spins up Windows host and a Linux host with caldera and Splunk UF configured

## Rationale

The target machines windows / linux needs to be created as VMs, it is easy and convinient to use Vagrant for configuring entire environment rather than using the docker for caldera.

## Project Plan

This project aims to be built as a detection engineering pipeline to understand what behaviors are getting detected and what are not getting detected. To do this, [zircolite](https://github.com/wagga40/Zircolite) can be used.

## Usage

```shell

vagrant up

```

## TODO

- [ ] Linux Machine
  - [ ] Setup Splunk
- [ ] Windows Machine
  - [ ] Setup UF
  - [ ] Setup Caldera client
  - [ ] Setup Sysmon with log-all configuration
- [ ] Setup Zircolite to analyze the EVTX files
