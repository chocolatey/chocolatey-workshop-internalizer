# Chocolatey Workshop - Interalizer

This is the material for the workshop "Setting up Internal Chocolatey Deployments" written by Gary Ewan Park and Paul Broadwith.

## Content

Software management and deployment is already a task, getting that good base of infrastructure in place right definitely helps. When you are using Chocolatey for software deployments, there are some recommendations on how to set up source control and testing infrastructure, not to mention how best to set up your production deployment infrastructure for success. Achieving reliability, repeatability, and scale is important in any organization - come let us show you how to easily achieve all of that.

In this workshop you will get hands on experience with:

- Setting up your workstation for Chocolatey packaging (best tools to use)
- Preparing Chocolatey for internal use
- Setting up a package repository (Chocolatey.Server)
- Setting up a CI system (Jenkins)
- Testing software deployments

## Workshop slides

- The most recent slides for this presentation can be found here [![GitPitch](https://gitpitch.com/assets/badge.svg)](https://gitpitch.com/chocolatey/chocolatey-workshop-internalizer/master)

## Past workshops

- This presentation was given at [Chocolatey Fest 2018](https://chocolateyfest.com/) on 8th October 2018
  - The slides can be found here [![GitPitch](https://gitpitch.com/assets/badge.svg)](https://gitpitch.com/chocolatey/chocolatey-workshop-internalizer/chocolateyfest2018)
- This presentation was given at [WinOps 2018](https://www.winops.org/london-2018/) on 15th November 2018
  - The slides can be found here [![GitPitch](https://gitpitch.com/assets/badge.svg)](https://gitpitch.com/chocolatey/chocolatey-workshop-internalizer/winops2018)

## Running the workshop

- Prepare a couple of Win2016 VM's in in your favourite cloud.
- You can use the Terraform templates in the `prepare-vms` folder to create VM's in Azure or AWS.
- Check and increase your limits two weeks before running the workshop.
- Check and ask in advance if your workshop location allows outgoing RDP connections at port 3389.

## Problems? Questions? Feedback?

- If you have problems, found a bug or have questions, don't hesitate to contact us.
- Open an issue in this repository or send me a pull request.

Have fun!

## Thanks

This workshop would not have been possible without the amazing work of [Stefan Scherer](https://github.com/StefanScherer).  The contents of this workshop are based on the work that Stefan did in this [repository](https://github.com/StefanScherer/windows-docker-workshop), where he shows how to put together a full workshop environment using Packer, Terraform and Azure.
