@title[Setting Up Internal Chocolatey Deployments]

## Setting Up Internal Chocolatey Deployments
### Using Jenkins Chocolatey.Server and Package Internalizer

![WinOps Logo](assets/images/winops_logo.png)

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
![Gary Ewan Park](assets/images/gary-avatar.png)
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
![Paul Broadwith](assets/images/paul.png)
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

@title[Agenda]
@transition[none]

@snap[north-west]
@css[choco-blue](Agenda)
@snapend

@title[Agenda]
@transition[none]

@snap[north-west]
@css[choco-blue](Agenda)
@snapend

@snap[west]
@ul[](false)
- 13:30: Workshop Starts
- 15:00: Coffee Break
- 17:00: Workshop Ends
@ulend
<br/><br/>
Please feel free to interrupt for any questions that you might have.
@snapend

---
@title[Agenda]
@transition[none]

@snap[north-west]
Agenda
@snapend

@snap[west]
@ul[](false)
- Get access to Workshop Environments
- Chocolatey Fundamentals
- Manual Internalization
- Package Internalizer Fundamentals
- Automatic Package Internalization
@ulend
@snapend
---

@title[Pre-Requisites]
@transition[none]

@snap[north-west]
@css[choco-blue](Pre-Requisites)
@snapend

@snap[west]
@ul[](false)
- Computer with network connection and RDP client
  - on Windows, you are probably all set
  - on macOS, get Microsoft Remote Desktop from the App Store
  - on Linux, get [remmina](https://wiki.ubuntuusers.de/remmina/)
- Some Chocolatey knowledge
  - but it's OK if you are not a Chocolatey expert!
@ulend
@snapend
---

@title[Hands-on Sections]
@transition[none]

@snap[north-west]
@css[choco-blue](Hands-on Sections)
@snapend

@snap[north span-100]
<br><br>
@ul[](false)
- Uses Chocolatey 0.10.11, Chocolatey.Server 0.2.5, and Jenkins 2.138.1
- All hands-on section are clearly identified, like the rectangle below:
@ulend
@snapend

@snap[south exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>
@ul[](false)
- This is the stuff you are supposed to do!
- Go to https://gitpitch.com/chocolatey/chocolatey-workshop-internalizer/master to view these slides.
@ulend

@snapend

---

@title[Terminals]
@transition[none]

@snap[north-west]
@css[choco-blue](Terminals)
@snapend

Once in a while, the instructions will say:

@quote[Open a new terminal]

![PowerShell Terminal](assets/images/terminal.png)

This needs to be an Administrator session.
* Press [Windows], type `powershell`, right click on entry and select `Run as Administrator`

---

@title[Test RDP Access]
@transition[none]

@snap[north-west]
@css[choco-blue](Test RDP Access)
@snapend

You should have been given a piece of paper like this:

![RDP Access](assets/images/rdp-access.png)

Test login credentials to make sure you have access.

**NOTE:** Initial login will likely cause a reboot of VM.

---

## Chocolatey Fundamentals

+++

@title[What is Chocolatey?]

## What is Chocolatey?

+++

@title[A Definition...]

### A Definition...

@quote[Chocolatey is a package manager for Windows, like apt-get or yum but for Windows. It was designed to be a decentralized framework for quickly installing applications and tools that you need. It is built on the NuGet infrastructure currently using PowerShell as its focus for delivering packages from the distros to your door, err computer.]

+++

@title[It's Magic!]

![It's Magic](assets/images/magic.gif)

+++

## Install putty

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco install putty.install</span></code></pre>

@snapend

+++

## Result

![Output from choco install putty](assets/images/choco-install-putty.png)

+++

## Sources

What is a Chocolatey Source?

+++

## List current Sources

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco source</span><span class="line">choco source list</span></code></pre>

@snapend

+++

## Result

![Output from choco source](assets/images/choco-source.png)

+++

## Add Test Repository Source

<pre><code class="lang-powershell hljs"><span class="line">choco source add --name="'testrepo'" &#x60;
  --source="'http://localhost/chocolatey'" &#x60;
  --priority="'2'" --bypass-proxy --allow-self-service
</span></code></pre>

+++

## Result

![Output from choco source add testrepo](assets/images/choco-source-add-test-repo.png)

+++

## Add Production Repository Source

<pre><code class="lang-powershell hljs"><span class="line">choco source add --name="'prodrepo'" &#x60;
  --source="'http://localhost:81/chocolatey'" &#x60;
  --priority="'2'" --bypass-proxy --allow-self-service
</span></code></pre>

+++

## Result

![Output from choco source add prodrepo](assets/images/choco-source-add-prod-repo.png)

+++

## List Sources Again...

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco source</span><span class="line">choco source list</span></code></pre>

@snapend

+++

## Result

![Output from choco source](assets/images/choco-source-more.png)

+++

## List local packages

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco list -lo</span><span class="line">choco list --local-only</span></code></pre>
@snapend

+++

## Result

![Output from choco list -lo](assets/images/choco-list-lo.png)

+++

## List all packages

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco list -li</span><span class="line">choco list --local-only --include-programs</span></code></pre>
@snapend

+++

## Result

![Output from choco list -li](assets/images/choco-list-li.png)

+++

## Checking for outdated packages

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco outdated</span></code></pre>

+++

## Result

![Output from choco outdated](assets/images/choco-outdated.png)

+++

## Upgrade all packages

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco upgrade all</span></code></pre>

+++

## Result

![Output from choco upgrade all](assets/images/choco-upgrade-all.png)

+++

## Reduce size of files on disk

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco optimize</span><span class="line">choco optimize --reduce-nupkg-only</span></code></pre>

+++

## Result

![Output from choco optimize](assets/images/choco-optimize.png)

---

@title[Why do I need to internalize packages?]
## Why do I need to internalize packages?

+++

* Reliability
* Trust and Control
* https://chocolatey.org/docs/community-packages-disclaimer

---

## Manual Internalization

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">mkdir winops</span><span class="line">cd winops</span><span class="line">choco download putty.install</span><span class="line">ii .</span></code></pre>

+++

## Result

![Output from choco download](assets/images/choco-download-putty.install.png)

+++

![Result of choco download](assets/images/choco-download-putty.install-2.png)
![Result of choco download](assets/images/choco-download-putty.install-3.png)

+++

## That was too easy...

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco download launchy</span></code></pre>

+++

## Result

![Output from choco download](assets/images/choco-download-launchy.png)

+++

![Result of choco download](assets/images/choco-download-launchy-2.png)
![Result of choco download](assets/images/choco-download-launchy-3.png)

+++

## Perform manual internalization steps

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)
- Download Launchy.exe
- Place within the chocolatey package folder
- Modify chocolateyInstall.ps1 file to use new location
- Switch to using `Install-ChocolateyInstallPackage`
- Or use `-UseOriginalLocation` flag
- Run `choco pack` to generate package
- Deploy and test
@ulend

+++

## Answer 1

Either simply append `-UseOriginalLocation` flag to the contents of the `chocolateyInstall.ps1` file

![Append UseOriginalLocation](assets/images/choco-download-launchy-4.png)

+++

## Answer 2

Update to latest best practices for a Chocolatey Package

![Update to latest best practices](assets/images/choco-download-launchy-5.png)

+++

## The easy way...

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>
<pre><code class="lang-powershell hljs"><span class="line">mkdir c:/Users/training/winops/take2</span><span class="line">cd c:/Users/training/winops/take2</span><span class="line"> </span><span class="line">choco download launchy &#x60;</span><span class="line">  --internalize &#x60;</span><span class="line">  --internalize-all-urls &#x60;</span><span class="line">  --append-use-original-location</span>

@snapend

+++

## Result

![Output from choco download](assets/images/choco-download-launchy-6.png)

+++

![Result of choco download](assets/images/choco-download-launchy-7.png)
![Result of choco download](assets/images/choco-download-launchy-8.png)

+++

## Push Package to Chocolatey.Server

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco source list</span><span class="line">choco list --source="'http://localhost/chocolatey'"</span><span class="line">choco push ./launchy.2.5.0.20140301.nupkg &#x60;
  --source="'http://localhost/chocolatey'"
</span></code></pre>

This will error out.  We need to know the Api Key to push packages to this feed

@snapend

+++

## Get Api Key

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)
- Navigate to `C:\tools\chocolatey.server`
- Open `web.config` file in text editor
- Search for `apiKey`
- Take a note of the value
@ulend

@snapend

+++

## Push Package to Chocolatey.Server - Take 2

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco push ./launchy.2.5.0.20140301.nupkg &#x60;
  --source="'http://localhost/chocolatey'" &#x60;
  --api-key chocolateyrocks
</span></code></pre>

+++

## Results

![Output from choco push](assets/images/choco-push.png)

+++

## Verify package is now available

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco list --source="'http://localhost/chocolatey'"</span></code></pre>
@snapend

+++

## Results

![Output from choco list](assets/images/choco-list.png)

---

## Internalize Packages

---?image=assets/images/choco-arch.png&size=contain&color=white

---?image=assets/images/choco-arch-internalizer.png&size=contain&color=white

@transition[none]
@snap[north-west]
<br />
<ul>
  <li style="color: black">Internalizing</li>
  <li style="color: black">Testing</li>
  <li style="color: black">Deployment</li>
</ul>
@snapend
---

@title[What are we trying to achieve?]

## What are we trying to achieve?

- Reliable package source
- Trusted package contents
- Working golden images

---

@title[Using Community Repository]

## Using Community Repository

- Over 6100 _unique_ packages on Chocolatey.org
- Leverage pre-built packages
- Internalize them for best of both worlds

---

@title[Internalizing To Test Repository]

## Internalizing To Test Repository

- Primary internal feed for all new packages
- Master feed to manage

+++

@title[Test Repository Internalization Scripts]

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)
- Open Command Window
- Enter `cd c:\scripts`
- Enter `code`
- Open `Get-UpdatedPackage.ps1` script
- Open `ConvertTo-ChocoObject.ps1` script
@ulend
@snapend

---

@title[Testing Packages]

## Testing Packages

- Pester / PSScriptAnalyzer
- Identify test machines
- Working with golden images? (Vagrant / VM)

+++

@title[Testing Packages Code]

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)
- Open Command Window
- Enter `cd c:\scripts`
- Enter `code`
- Open `Update-ProdRepoFromTest.ps1` script
- Open `Test-Package.ps1` script
- Uncomment out the lines for checking exit code
@ulend
@snapend

+++

@title[Testing Packages Code]

## Other Package Tests

- Command / EXE is present
- URL / port / path is available
- VM / Docker image to test packages
- Any others?

---

@title[Push To Internal Production Repository]

## Push To Internal Production Repository

- Master feed for production deployment
- Tested packages
- Working in your environment

+++

@title[Testing Packages Code]

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)
- Open Command Window
- Enter `cd c:\scripts`
- Enter `code`
- Open `Update-ProdRepoFromTest.ps1` script
@ulend
@snapend

---

@title[How Do We Make This Work?]

## How Do We Make All Of This Work?

- Repositories - **Chocolatey.Server**
- Scripts - **PowerShell**
- Automation - **Jenkins**

---

@title[Why Use Chocolatey.Server]

## Why Use Chocolatey.Server?

- Simple to setup
- Chocolatey package and scripted config
- Nexus, Artifactory, MyGet and others instead

---

@title[Why use PowerShell?]

## Why PowerShell?

- Chocolatey supports it natively
- Widely used in Windows environments
- Give admins what they know

---

@title[Why use Jenkins?]

## Why Jenkins?

- Widely used
- Over 100,000 installs
- Give admins what they know

+++

## Initial Jenkins Setup

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)
- Open Windows Explorer
- Navigate to `c:\Program Files (x86)\Jenkins\secrets`
- Open initialAdminPassword file in text editor
- Find password in secret file and copy it
- Open Jenkins in browser http://localhost:8080
- Use username admin and paste admin password and then login
@ulend
@snapend

---

## Real World Scenarios

---
@title[Finance Need AdobeReader Installed]

## Finance Need AdobeReader Installed

- Package needs created
- Needs tested on golden images
- Needs deployed to estate

+++
## Finance Need AdobeReader Installed

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)

- Open Jenkins
- Click **Internalize Packages** Job
- Click **Build with parameters**
- At **P_PKG_LIST** enter `adobereader`
- Click **Build**

@ulend
@snapend

+++

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise - continued
<br>

@ul[](false)
- Package has been internalized
- Find it in the repositories
- Check the test repository
@ulend

<pre><code class="lang-powershell hljs"><span class="line">choco list -s http://localhost/chocolatey</span></code></pre>

@ul[](false)
- Check the production repository
@ulend

<pre><code class="lang-powershell hljs"><span class="line">choco list -s http://localhost:81/chocolatey</span></code></pre>

@snapend

---
@title[Dev Team Finished The App!]

## Dev Team Finally Finish The App

- Passed to Ops for deployment
- Needs tested on golden images
- Needs deployed to estate

+++

## Lets Create The App Package

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)

- Create a temp directory and change to it
<pre><code class="lang-powershell hljs"><span class="line">`choco new newapp`</span></code></pre>
- In the `newapp` folder created, delete all files except `newapp.nuspec` and `tools\chocolateyInstall.ps1`


@ulend
@snapend

+++

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise - continued
<br>

@ul[](false)
- Replace the contents of `tools\chocolateyInstall.ps1` with `Write-Host "New app is installed!"`
- In `newapp.nuspec` change the version field number to `1.2.3`
- In a terminal, navigate to the folder where the nuspec was created and run:
<pre><code class="lang-powershell hljs"><span class="line">`choco pack`<span></code></pre>
@ulend
@snapend

+++

## Lets Push The App Package

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)
- Run
<pre><code class="lang-powershell hljs"><span class="line">choco push &#x60;
  newapp.1.2.3.nupkg &#x60;
  -s http://localhost/chocolatey &#x60;
  --api-key chocolateyrocks<span></code></pre>
- Run
<pre><code class="lang-powershell hljs"><span class="line">choco list -s http://localhost/chocolatey</span></code></pre>
- and make sure the `newapp` package is shown in test repository
@ulend
@snapend

+++

## Lets Sync The App To Production

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)
- Go to Jenkins and run the job **Sync Production Repository From Test** with default parameters
- Run
<pre><code class="lang-powershell hljs"><span class="line">choco list -s http://localhost:81/chocolatey</span></code></pre>
- and make sure the `newapp` package is shown in production repository

@ulend
@snapend

---
@title[7Zip has a security vulnerability!]

## 7Zip has a security vulnerability!

- A CVE has been released for 7Zip
- Need to test and release this asap!
- Needs deployed to estate

+++
@title[7Zip has a security vulnerability!]

## Push Old Version Of 7Zip

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)
- Run
<pre><code class="lang-powershell hljs"><span class="line">choco download 7zip.install --version 18.1 --internalize --force &#x60;
  --internalize-all-urls &#x60;
  --append-use-original-location &#x60;
  --no-progress &#x60;
  --source='https://chocolatey.org/api/v2/'</span></code></pre>
- Run
<pre><code class="lang-powershell hljs"><span class="line">choco push 7zip.install.18.1.nupkg &#x60;
  --source="'http://localhost/chocolatey'" &#x60;
  --api-key chocolateyrocks</span></code></pre>

@ulend
@snapend

+++

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise - continued
<br>

@ul[](false)

- Run
<pre><code class="lang-powershell hljs"><span class="line">choco push chocolatey-core.extension.1.3.3.nupkg &#x60;
  --source="'http://localhost/chocolatey'" &#x60;
  --api-key chocolateyrocks</span></code></pre>
- Check test repository has the outdated package
@ulend
@snapend

+++

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)
- Run
<pre><code class="lang-powershell hljs"><span class="line">choco list -s http://localhost/chocolatey</span></code></pre>
- Go to Jenkins and run the job **Sync Production Repository From Test** with default parameters
- Run
<pre><code class="lang-powershell hljs"><span class="line">choco list -s http://localhost:81/chocolatey</span></code></pre>
- and make sure version `18.1` of `7zip.install` is shown
@ulend
@snapend

+++

@title[7Zip has a security vulnerability!]

## Update Test Packages From Community Repository

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)

- Check the newest version is available in the community repository
- Run
<pre><code class="lang-powershell hljs"><span class="line">choco list 7zip.install</span></code></pre>
- This new version does not have the vulnerability!
- Update your repositories
- Go to Jenkins and run the job **Update Test Repository Package Versions**


@ulend
@snapend

+++

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise - continued
<br>

@ul[](false)
- Check the new version is in the test repository
- Run
<pre><code class="lang-powershell hljs"><span class="line">choco list -s http://localhost/chocolatey</span></code></pre>
- Check the new version has been pushed to the production repository
- Run
<pre><code class="lang-powershell hljs"><span class="line">choco list -s http://localhost:81/chocolatey</span></code></pre>
@ulend
@snapen
---
## What Are Your Real World Scenarios?

---

@title[Questions]
## Questions?

Feel free to get in touch after the workshop.

Email: gary@chocolatey.io / paul@chocolatey.io

Twitter: @gep13 / @pauby

Web: https://chocolatey.org

---

@title[Let's go off script...]
## Let's go off script...

+++

## Install Chocolatey Beta

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)

<pre><code class="lang-powershell hljs"><span class="line">choco upgrade chocolatey --version=0.10.12-beta-20181011             </span></code></pre>

@ulend
@snapend

+++

## Install Chocolatey Extension Beta

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)

<pre><code class="lang-powershell hljs"><span class="line">choco upgrade chocolatey.extension --version=2.0.0-beta-20181009             </span></code></pre>

@ulend
@snapend

+++

## Install Chocolatey Agent Beta

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)

<pre><code class="lang-powershell hljs"><span class="line">choco upgrade chocolatey-agent --version=0.9.0-beta-20181009             </span></code></pre>

@ulend
@snapend

+++

## Configure Chocolatey Central Management

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)

<pre><code class="lang-powershell hljs"><span class="line">choco config set centralManagementReportPackagesTimerIntervalInSeconds 60             </span><span class="line">choco config set centralManagementServiceUrl "https://winops-01:24040/ChocolateyManagementService"</span><span class="line">choco config set centralManagementReceiveTimeoutInSeconds 60</span><span class="line">choco config set centralManagementSendTimeoutInSeconds 60</span><span class="line">choco config set centralManagementCertificateValidationMode "PeerOrChainTrust"</span></code></pre>

@ulend
@snapend

+++

## Enable Chocolatey Central Management

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)

<pre><code class="lang-powershell hljs"><span class="line">choco feature enable --name="'useChocolateyCentralManagement'"             </span></code></pre>

@ulend
@snapend

---

@title[Resources]
## Resources

* Chocolatey Documentation - https://chocolatey.org/docs
* Gitter Chat - https://gitter.im/chocolatey/choco
* Google Groups - https://groups.google.com/forum/#!forum/chocolatey
* Learning Resources - https://chocolatey.org/docs/resources
* How To Use Package Internalizer To Create Internal Package Source - https://chocolatey.org/docs/how-to-setup-internal-package-repository
