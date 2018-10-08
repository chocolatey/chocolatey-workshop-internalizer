@title[Setting Up Internal Chocolatey Deployments]

## Setting Up Internal Chocolatey Deployments
### Using Jenkins and Package Internalizer

![ChocolateyFest Logo](assets/images/cf-logo.png)

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
- 18:30: Workshop Starts
- 19:30: Comfort Break
- 20:30: Comfort Break
- 21:30: Workshop Ends
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
  - on Linux, get [rdesktop](https://wiki.ubuntuusers.de/rdesktop/)
- Some Chocolatey knowledge
  - but it's OK if you are not a Chocolatey expert!)
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
- Go to https://gitpitch.com/gep13/chocolatey-internalizer-workshop/master to view these slides.
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

<pre><code class="lang-powershell hljs"><span class="line">choco install putty</span></code></pre>

@snapend

+++

## Result

![Output from choco install putty](assets/images/choco-install-putty.png)

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

## Upgrade all packages

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco upgrade all</span></code></pre>

+++

## Result

![Output from choco upgrade all](assets/images/choco-upgrade-all.png)

+++

## Viewing Chocolatey Sources

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco source</span><span class="line">choco source list</span></code></pre>

+++

## Result

![Output from choco source](assets/images/choco-source.png)

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

<pre><code class="lang-powershell hljs"><span class="line">mkdir chocolateyfest</span><span class="line">cd chocolateyfest</span><span class="line">choco download putty.install</span><span class="line">ii .</span></code></pre>

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

## The easy way...

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

<pre><code class="lang-powershell hljs"><span class="line">choco download launchy &#x60;</span><span class="line">  --internalize &#x60;</span><span class="line">  --internalize-all-urls &#x60;</span><span class="line">  --append-use-original-location</span>

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

<pre><code class="lang-powershell hljs"><span class="line">choco source list</span><span class="line">choco list --source="'http://localhost/chocolatey'"</span><span class="line">choco push ./launchy.2.5.0.20140301.nupkg `
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

<pre><code class="lang-powershell hljs"><span class="line">choco push ./launchy.2.5.0.20140301.nupkg `
  --source="'http://localhost/chocolatey'" `
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
  <li style="color: black">Interalizing</li>
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

- Over 6000 _unique_ packages on Chocolatey.org
- Leverage pre-built packages
- Internalize them for best of both worlds

---

@title[Internalizing To Test Repository]

## Internalizing To Test Repository

- Primary internal feed for all new packages
- Master feed to manage

---

@title[Testing Packages]

## Testing Packages

- Pester / PSScriptAnalyzer
- Identify test machines
- Working with golden images? (Vagrant / VM)

---

@title[Push To Internal Production Repository]

## Push To Internal Production Repository

- Master feed for production deployment
- Tested packages
- Working in your environment

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

## Log into Jenkins

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)
- Open Windows Explorer
- Navigate to c:/Program Files (x86)/Jenkins/secrets
- Open initialAdminPassword file in text editor
- Find password in secret file
- Login into Jenkins with username admin and this password
@ulend
@snapend

---

## Automate Internalization With Jenkins Jobs

- Add automation jobs
- PowerShell code does the heavy lifting
- Jobs:
  - Update Test Repository Package Versions

+++

## Create Jenkins Jobs
### Update Test Repository Package Versions

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)

- Click **New Item**
- Name the job `Update Test Repository Package Versions`
- Click **Pipeline**
- CLick **OK**
- Tick options: **This project is parameterized** and **Do not allow concurrent builds**;
- Click **Add parameter**
- Add **string** parameter `P_LOCAL_REPO_URL` with value `http://localhost/chocolatey`
- Add **string** parameter `P_REMOTE_REPO_URL` with value `https://chocolatey.org/api/v2/`
- Add **password** parameter `P_LOCAL_REPO_API_KEY` with value `chocolateyrocks`
@ulend
@snapend

+++

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise - continued
<br>

@ul[](false)

- Take a look at `C:\Scripts\Get-UpdatedPackage.ps1`
- Add pipeline script:

<pre><code class="lang-powershell hljs"><span class="line">
node {
    powershell '''
        Set-Location (Join-Path -Path $env:SystemDrive -ChildPath 'scripts')
        .\\Get-UpdatedPackage.ps1 -LocalRepo $env:P_LOCAL_REPO_URL `
            -LocalRepoApiKey $env:P_LOCAL_REPO_API_KEY `
            -RemoteRepo $env:P_REMOTE_REPO_URL `
            -Verbose
    '''
}
</span></code></pre>

- Click ***Save***
@ulend
@snapend

+++

## Create Jenkins Jobs
### Internalize Packages

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)

- Click **New Item**
- Name the job `Internalize Packages`
- Click **Pipeline**
- Click **OK**
- Tick options: **This project is parameterized** and **Do not allow concurrent builds**;

@ulend
@snapend

+++

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise - continued
<br>

@ul[](false)

- Add **string** parameter `P_PKG_LIST` with blank value
- Add **string** parameter `P_DST_URL` with value `http://localhost/chocolatey`
- Add **password** parameter `P_API_KEY` with value `chocolateyrocks`

@ulend
@snapend

+++

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise - continued
<br>

@ul[](false)
- Add pipeline script:

<pre><code class="lang-powershell hljs"><span class="line">
node {
    powershell '''
        $temp = Join-Path -Path $env:TEMP -ChildPath ([GUID]::NewGuid()).Guid
        $null = New-Item -Path $temp -ItemType Directory
        Write-Output "Created temporary directory '$temp'."
        ($env:P_PKG_LIST).split(';') | ForEach-Object {
            choco download $_ --no-progress --internalize --force --internalize-all-urls --append-use-original-location --output-directory=$temp --source='https://chocolatey.org/api/v2/'
            if ($LASTEXITCODE -eq 0) {
                $package = (Get-Item -Path (Join-Path -Path $temp -ChildPath "$_*.nupkg")).fullname
                choco push $package --source "$($env:P_DST_URL)" --api-key "$($env:P_API_KEY)" --force
            }
            else {
                Write-Output "Failed to download package '$_'"
            }
        }
        Remove-Item -Path $temp -Force -Recurse
    '''
}
</span></code></pre>

- Click Save
@ulend
@snapend

+++

## Create Jenkins Jobs
### Sync Production Repository From Test

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)

- Click **New Item**
- Name the job `Sync Production Repository From Test`
- Click **Pipeline**
- Click **OK**
- Tick options: **This project is parameterized** and **Do not allow concurrent builds**;
- Add **string** parameter `P_PROD_REPO_URL` with value `http://localhost:81/chocolatey`
- Add **password** parameter `P_PROD_REPO_API_KEY` with value `chocolateyrocks`
- Add **string** parameter `P_TEST_REPO_URL` with value `http://localhost/chocolatey`
- Tick **Build after other projects are built**
- At **Projects to watch** Add `Internalize Packages, Update Test Repository Package Versions`

@ulend
@snapend

+++

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise - continued
<br>

@ul[](false)

- Add **string** parameter `P_PROD_REPO_URL` with value `http://localhost:81/chocolatey`
- Add **password** parameter `P_PROD_REPO_API_KEY` with value `chocolateyrocks`
- Add **string** parameter `P_TEST_REPO_URL` with value `http://localhost/chocolatey`
- Tick **Build after other projects are built**
- At **Projects to watch** Add `Internalize Packages, Update Test Repository Package Versions`
@ulend
@snapend

+++

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)
- Take a look at the code in `C:\Scripts\Update-ProdRepoFromTest.ps1`
- Add pipeline script:

<pre><code class="lang-powershell hljs"><span class="line">
node {
    powershell '''
        Set-Location (Join-Path -Path $env:SystemDrive -ChildPath 'scripts')
        .\\Update-ProdRepoFromTest.ps1 `
            -ProdRepo $env:P_PROD_REPO_URL `
            -ProdRepoApiKey $env:P_PROD_REPO_API_KEY `
            -TestRepo $env:P_TEST_REPO_URL `
            -Verbose
    '''
}
</span></code></pre>

- Click ***Save***

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

- Click **Internalize Packages**
- Click **Build with parameters**
- At **P_PKG_LIST** enter `adobereader`
- Click **Build**

@ulend
@snapend

+++

## Finance Need AdobeReader Installed

@snap[center exercise-box]

- Package has been internalized
- Find it in the repositories

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)

- Check the test repository
- PowerShell Command: `choco list -s http://localhost/chocolatey`
- Check the production repository
- PowerShell Command: `choco list -s http://localhost:81/chocolatey`

@ulend
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
- run `choco new newapp`
- In the `newapp` folder created, delete all files except `newapp.nuspec` and `tools\chocoInstall.ps1`
- Replace the contents of `tools\chocoInstall.ps1` with `Write-Host "New app is installed!"`
- In `newapp.nuspec` change the version field number to `1.2.3`
- Run `choco pack` to create a new `.nupkg` file

@ulend
@snapend

+++

## Lets Push The App Package

@snap[center exercise-box]

@fa[keyboard-o]()&nbsp;Exercise
<br>

@ul[](false)

- Run `choco push newapp.1.2.3.nupkg -s http://localhost/chocolatey`
- Run `choco list -s http://loclhost/chocolatey` and make sure the `newapp` package is shown
- Go to Jenkins and run the job **Sync Production Repository From Test** with default parameters
- Run `choco list -s http://localhost:81/chocolatey` and make sure the `newapp` package is shown

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

- Run: `choco download 7zip.install --version 18.1 --no-progress --internalize --force --internalize-all-urls --append-use-original-location --source='https://chocolatey.org/api/v2/'`
- Run: `choco push 7zip.install.18.1.nupkg -s http://localhost/chocolatey`
- Check test repository has the outdated package
- Run: `choco list -s http://localhost/chocolatey`
- Go to Jenkins and run the job **Sync Production Repository From Test** with default parameters
- Run `choco list -s http://localhost:81/chocolatey` and make sure version `18.1` of `7zip.install` is shown

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
- Run: `choco list 7zip.install`
- This new version does not have the vulnerability!
- Update your repositories
- Go to Jenkins and run the job **Update Test Repository Package Versions**
- Check the new version is in the test repository
- Run: `choco list -s http://localhost/chocolatey`
- Check the new version has been pushed to the test repository
- Run `choco list -s http://localhost:81/chocolatey`

@ulend
@snapend

---
## What Are Your Real World Scenarios?

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
