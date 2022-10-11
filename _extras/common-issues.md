---
title: "Common Issues, Fixes & Tips"
---

Here is a list of issues previous participants of the course encountered and some tips to help you with troubleshooting.

## Command Line/Git Bash Issues
 
### Python Hangs in Git Bash
Hanging issues with trying to run Python 3 in Git Bash on Windows (i.e. typing `python` in the shell, which causes 
it to just hang with no error message or output). The solution appears to be to use `winpty` - a Windows software 
package providing an interface similar to a Unix pty-master for communicating with Windows command line tools.
Inside the shell type `alias python='winpty python.exe'`. This alias will be valid for the duration of the shell 
session. For a more permanent solution, from the shell do: `echo "alias python='winpty python.exe'" >> ~/.bashrc` 
(and from there on remember to invoke Python as `python` or whatever command you aliased it to). 
Read more details on the issue at [Stack Overflow](https://stackoverflow.com/questions/32597209/python-not-working-in-the-command-line-of-git-bash) or [Superuser](https://superuser.com/questions/1403345/git-bash-not-running-python3-as-expected-hanging-issues).

### Customising Command Line Prompt
Minor annoyance with the ultra long prompt command line sometimes gives you - if you do not want a reminder of the 
current working directory, you can just set it to `$` by typing the following in your command line: `export PS1="$ "`.
More details on command line prompt customisation can be found in this [guide](https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html).

## Git/GitHub Issues

### Creating a GitHub Key Without 'Workflow' Authorisation Scope
If  learner creates a GitHub authentication token but forgets to check 'workflow' scope (to allow the token to be used to update GitHub Action workflows) they will get the following error when trying to 
push a new workflow (when adding the `pytest` action in Section 2) to GitHub:

~~~
! [remote rejected] test-suite -> test-suite (refusing to allow an OAuth App to create or update workflow `.github/workflows/main.yml` without `workflow` scope`
~~~
{: .language-bash}
        
The solution is to generate a new token with the correct scope/usage permissions and clear the local 
credential cache (if that's where the token has been saved). In same cases, simply clearing 
credential cache was not enough and updating to Git 2.29 was needed.

## Python, `pip`, `venv` & Installing Packages Issues

### Issues With Numpy (and Potentially Other Packages) on New M1 Macs 

When using `numpy` installed via `pip` on a command line on a new Apple M1 Mac, you get a failed installation with the error: 

> ...
> mach-o file, but is an incompatible architecture (have 'x86_64', need 'arm64e').
> ...
 
Numpy is a package heavily optimised for performance, and many parts of it are written in C and compiled for specific architectures, such as Intel (x86_64, x86_32, etc.) or Apple's M1 (arm64e). In this instance, pip is obtaining a version of `numpy` with the incorrect compiled binaries, instead of the ones needed for Apple's M1 Mac. One way that was found to work was to install numpy via PyCharm into your environment instead, which seems able to determine the correct packages to download and install.

### Python 3 not Accessible as `python3` but `python`
Python 3 installed on some Windows machines may not be accessible as `python3` from the command line, but 
works fine when invoked with `python`.

### Installing Packages With `pip` Issue Over VPN or Protected Networks - Proxy Needed
If you encounter issues when trying to install packages with `pip` over your organisational network - 
it may be because your may need to use a proxy provided by your organisation. In order 
to get `pip` to use the proxy, you need to add an additional parameter when installing packages with `pip`:

`pip3 install --proxy <proxy-url> <name of package>`

To keep these settings permanently, you may want to add the following to your `.zshrc`/`.bashrc` file to avoid 
having to specify the proxy for each session, and restart your command line terminal:
~~~
# call set_proxies to set proxies and unset_proxies to remove them
set_proxies() {
export {http,https,ftp}_proxy='<proxy-url>'
export {HTTP,HTTPS,FTP}_PROXY='<proxy-url>'
export NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24,192.168.64.2,.<proxy-url>, <proxy-url>
}

unset_proxies() {
export {http,https,ftp}_proxy=
export {HTTP,HTTPS,FTP}_PROXY=
export NO_PROXY=
}
~~~
{: .language-bash}

## PyCharm Issues
 
### Using GitBash from PyCharm
To embed Git Bash in PyCharm as external tool and work with it in PyCharm window, from Settings select 
"Tools->Terminal->Shell path" and enter `“C:\Program Files\Git\bin\sh.exe” --login`. See [more details](https://stackoverflow.com/questions/20573213/embed-git-bash-in-pycharm-as-external-tool-and-work-with-it-in-pycharm-window-w) on Stack Overflow.
                
### Virtual Environments Issue `"no such option: –build-dir"`
Using PyCharm to add a package to a virtual environment created from the command line using `venv` 
can fail with error `"no such option: –build-dir"`, which appears to be caused by the latest version of `pip` (20.3)
where the flag `-build-dir` was removed but is required by PyCharm to install packages. A workaround is to:
- Close PyCharm
- Downgrade the version of `pip` used by `venv`, e.g. in a command line terminal type: `python -m pip install pip==20.2.4`
- Restart PyCharm

See [the issue](https://youtrack.jetbrains.com/issue/PY-45712) for more details. 
This issue seems to only occur with older versions of PyCharm - recent versions should be fine.
     
### Invalid YAML Issue
If YAML is copy+pasted from the course material, it might not get pasted correctly in PyCharm and some 
extra indentation may occur. Annoyingly, PyCharm won't flag this up as invalid YAML and learners may get 
all sort of different issues and errors with these files - e.g. ‘actions must start with run or uses’ with 
GitHub Actions workflows.

An example of incorrect extra indentation:

~~~
steps:
    - name: foo
      uses: bar
~~~

Instead of
~~~
steps:
  - name: foo
    uses: bar
~~~

{% include links.md %}

