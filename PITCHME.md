@title[Setting Up Internal Chocolatey Deployments]

## Setting Up Internal Chocolatey Deployments
### Using Jenkins and Package Internalizer

![](assets/images/cf-logo.png)

---?image=assets/images/cf2018-sponsors.png&size=contain&color=white
@title[ChocolateyFest Sponsors]
@transition[none]

---?image=assets/images/wifi.png&size=contain&color=white
@title[Wifi]
@transition[none]

---

@title[Who Am I? - Gary Ewan Park]
@transition[none]

@snap[north-west]
@css[choco-blue](WHO AM I?)
@snapend

@snap[west span-65]
Senior Software Engineer @ Chocolatey Software
<br>
<br>
![MVP Logo](assets/images/mvp.jpg)
![Cake Build](assets/images/cake.png)
@snapend

@snap[east span-30]
![](assets/images/gary-avatar.png)
<br>
@css[bio-name](Gary Ewan Park)
@snapend

@snap[south-west bio-contact]
@fa[twitter twitter-blue]&nbsp;&nbsp;gep13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
@fa[github text-black]&nbsp;&nbsp;github.com/gep13&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
@fa[home text-blue]&nbsp;&nbsp;gep13.co.uk&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
@fa[envelope choco-blue]&nbsp;&nbsp;gary@chocolatey.io
@snapend

---
@title[Who Am I? - Paul Broadwith]
@transition[none]

@snap[north-west]
@css[choco-blue](WHO AM I?)
@snapend

@snap[west span-65]
Senior Technical Engineer @ Chocolatey Software
<br>
<br>
25+ years in IT in the defence, government, financial services and nuclear industry sectors
@snapend

@snap[east span-30]
![](assets/images/paul.png)
<br>
@css[bio-name](Paul Broadwith)
@snapend

@snap[south-west bio-contact]
@fa[twitter twitter-blue]&nbsp;&nbsp;pauby&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
@fa[github text-black]&nbsp;&nbsp;github.com/pauby&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
@fa[home text-blue]&nbsp;&nbsp;pauby.com&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
@fa[envelope choco-blue]&nbsp;&nbsp;paul@chocolatey.io
@snapend

---

## Agenda

---

## Pre-Requisites

---

## Hands-on Sections

---

## We will (mostly) interact with RDP only

---

## Terminals

---

## Test RDP Access

Make sure all passwords are working

---

## Chocolatey Fundamentals

---

@title[Why do I need to internalize packages?]
## Why do I need to internalize packages?

---

@title[What can't I just use the packages downloaded from chocolatey.org?]
## Why can't I just use the packages downloaded from chocolatey.org?

+++

## Manual Internalization

- This isn't fun

+++

## Exercise

- Run internalizer from command line
- Look at generated content
- Added switches to show different functionality

---

@title[Why use Chocolatey.Server?]
## Why use Chocolatey.Server?

+++

## Exercise - Chocolatey.Server

- push a package to chocolatey.server
- list the contents
- install the package

+++

## Exercise - Multiple Sources

- Change source priorities
- Disable/Remove chocolatey.org

---

@title[Why use Jenkins?]
## Why use Jenkins?

+++

## Exercise - Jenkins

- Login into Jenkins with username/password
- Find password in secret file
- Talk about plugins, why they are needed
- Scheduling the jobs

---

## Internalize Packages

- Image from docs

+++

## Set up first job

+++

## Set up second job

+++

## Setup third job

---

## Real World Scenarios

- what are we trying to achieve
- using Chocolatey.org as source for new package versions
- internalizing those onto test repository
- testing it out
- pushing to internal production repository

+++

## Exercise - Do that

- Old version of Putty pushed to chocolatey.server
- Run scripts, to watch internalization of new one

---

@title[Questions]
## Questions?

Feel free to get in touch

Email:
gary@chocolatey.io
paul@chocolatey.io

Twitter:
@gep13
@pauby

Web: https://chocolatey.org

---

@title[Resources]
## Resources

* Chocolatey Documentation - https://chocolatey.org/docs
* Gitter Chat - https://gitter.im/chocolatey/choco
* Google Groups - https://groups.google.com/forum/#!forum/chocolatey
* Learning Resources - https://chocolatey.org/docs/resources
* How To Use Package Internalizer To Create Internal Package Source - https://chocolatey.org/docs/how-to-setup-internal-package-repository
