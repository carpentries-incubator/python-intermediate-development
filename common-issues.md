---
title: Common Issues, Fixes & Tips
---

Here is a list of issues previous participants of the course encountered
and some tips to help you with troubleshooting.

## Command Line/Git Bash Issues

### Python Hangs in Git Bash

Hanging issues with trying to run Python 3 in Git Bash on Windows
(i.e. typing `python` in the shell, which causes it to just hang with no error message or output).
The solution appears to be to use `winpty` -
a Windows software package providing an interface similar to a Unix pty-master
for communicating with Windows command line tools.
Inside the shell type:

```bash
$ alias python="winpty python.exe"
```

This alias will be valid for the duration of the shell session.
For a more permanent solution, from the shell do:

```bash
$ echo "alias python='winpty python.exe'" >> ~/.bashrc
$ source ~/.bashrc
```

(and from there on remember to invoke Python as `python`
or whatever command you aliased it to).
Read more details on the issue at
[Stack Overflow](https://stackoverflow.com/questions/32597209/python-not-working-in-the-command-line-of-git-bash)
or [Superuser](https://superuser.com/questions/1403345/git-bash-not-running-python3-as-expected-hanging-issues).

### Customising Command Line Prompt

Minor annoyance with the ultra long prompt command line sometimes gives you -
if you do not want a reminder of the current working directory,
you can set it to just `$` by typing the following in your command line: `export PS1="$ "`.
More details on command line prompt customisation can be found in this
[guide](https://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html).

## Git/GitHub Issues

### Connection Issues When Accessing GitHub Using Git Over VPN or Protected Networks - Proxy Needed

When accessing external services and websites
(such as GitHub using `git` or to
[install Python packages with `pip`](../learners/common-issues.md#connection-issues-when-installing-packages-with-pip-over-vpn-or-protected-networks---proxy-needed)),
you may experience connection errors
(e.g. similar to `fatal: unable to access '....': Failed connect to github.com`)
or a connection that hangs.
This may indicate that they need to configure a proxy server user by your organisation
to tunnel SSH traffic through a HTTP proxy.

To get `git` to work through a proxy server in Windows,
you'll need `connect.exe` program that comes with GitBash
(which you should have installed as part of setup, so no additional installation is needed).
If installed in the default location,
this file should be found at `C:\Program Files\Git\mingw64\bin\connect.exe`.
Next, you'll need to modify your ssh config file (typically in `~/.ssh/config`)
and add the following:

```
Host github.com
    ProxyCommand "C:/Program Files/Git/mingw64/bin/connect.exe" -H <proxy-server>:<proxy-port> %h %p
    TCPKeepAlive yes
    IdentitiesOnly yes
    User git
    Port 22
    Hostname github.com
```

Mac and Linux users can use the [Corkscrew tool](https://github.com/bryanpkc/corkscrew)
for tunneling SSH through HTTP proxies,
which would have to be installed separately.
Next, you'll need to modify your SSH config file (typically in `~/.ssh/config`)
and add the following:

```
Host github.com
    ProxyCommand corkscrew <proxy-server> <proxy-port> %h %p
    TCPKeepAlive yes
    IdentitiesOnly yes
    User git
    Port 22
    Hostname github.com
```

### Creating a GitHub Key Without 'Workflow' Authorisation Scope

If a learner creates a GitHub authentication token
but forgets to check 'workflow' scope
(to allow the token to be used to update GitHub Action workflows)
they will get the following error when trying to push a new workflow
(when adding the `pytest` action in Section 2) to GitHub:

```error
! [remote rejected] test-suite -> test-suite (refusing to allow an OAuth App to create or update workflow `.github/workflows/main.yml` without `workflow` scope`
```

The solution is to generate a new token with the correct scope/usage permissions
and clear the local credential cache (if that's where the token has been saved).
In same cases, simply clearing credential cache was not enough and updating to Git 2.29 was needed.

### `Please tell me who you are` Git Error

If you experience the following error the first time you do a Git commit,
you may not have configured your identity with Git on your machine:

```error
fatal: unable to auto-detect email address
*** Please tell me who you are
```

This can be configured from the command line as follows:

```bash
$ git config --global user.name "Your Name"
$ git config --global user.email "name@example.com"
```

The option `--global` tells Git to use these settings "globally"
(i.e. for every project that uses Git for version control on your machine).
If you use different identifies for different projects,
then you should not use the `--global` option.
Make sure to use the same email address you used to open an account on GitHub
that you are using for this course.

At this point it may also be a good time to configure your favourite text editor with Git,
if you have not already done so.
For example, to use the editor `nano` with Git:

```bash
$ git config --global core.editor "nano -w"
```

## SSH key authentication issues with Git Bash

Git Bash uses its own SSH library by default, which may result in errors such as the one below
even after adding your SSH key correctly:

```
$ git clone git@github.com:https://github.com/ukaea-rse-training/python-intermediate-inflammation
Cloning into 'python-intermediate-inflammation'...
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

The solution is to change the SSH library used by Git:

```
$ git config --global core.sshCommand C:/windows/System32/OpenSSH/ssh.exe
```

## Python, `pip`, `venv` \& Installing Packages Issues

### Issues With Numpy (and Potentially Other Packages) on New M1 Macs

When using `numpy` package installed via `pip` on a command line on a new Apple M1 Mac,
you get a failed installation with the error:

```error
...
mach-o file, but is an incompatible architecture (have 'x86_64', need 'arm64e').
...
```

Numpy is a package heavily optimised for performance,
and many parts of it are written in C and compiled for specific architectures,
such as Intel (x86\_64, x86\_32, etc.)
or Apple's M1 (arm64e).
In this instance, `pip` is obtaining a version of `numpy` with the incorrect compiled binaries,
instead of the ones needed for Apple's M1 Mac.
One way that was found to work was to install numpy via PyCharm into your environment instead,
which seems able to determine the correct packages to download and install.

### Python 3 Installed but not Found When Using `python3` Command

Python 3 installed on some Windows machines
may not be accessible using the `python3` command from the command line,
but works fine when invoked via the command `python`.

### Connection Issues When Installing Packages With `pip` Over VPN or Protected Networks - Proxy Needed

If you encounter issues when trying to
install packages with `pip` over your organisational network -
it may be because your may need to
[use a proxy](https://stackoverflow.com/questions/30992717/proxy-awareness-with-pip)
provided by your organisation.
In order to get `pip` to use the proxy,
you need to add an additional parameter when installing packages with `pip`:

```bash
$ python3 -m pip install --proxy <proxy-url> <name of package>
```

To keep these settings permanently,
you may want to add the following to your `.zshrc`/`.bashrc` file
to avoid having to specify the proxy for each session,
and restart your command line terminal:

```
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
```

## PyCharm Issues

### Using GitBash from PyCharm

To embed Git Bash in PyCharm as external tool and work with it in PyCharm window,
from Settings
select "Tools->Terminal->Shell path"
and enter `"C:\Program Files\Git\bin\sh.exe" --login`.
See [more details](https://stackoverflow.com/questions/20573213/embed-git-bash-in-pycharm-as-external-tool-and-work-with-it-in-pycharm-window-w)
on Stack Overflow.

### Virtual Environments Issue `"no such option: –build-dir"`

Using PyCharm to add a package to a virtual environment created from the command line using `venv`
can fail with error `"no such option: –build-dir"`,
which appears to be caused by the latest version of `pip` (20.3)
where the flag `-build-dir` was removed but is required by PyCharm to install packages.
A workaround is to:

- Close PyCharm
- Downgrade the version of `pip` used by `venv`, e.g. in a command line terminal type:
  ```bash
  $ python3 -m pip install pip==20.2.4
  ```
- Restart PyCharm

See [the issue](https://youtrack.jetbrains.com/issue/PY-45712) for more details.
This issue seems to only occur with older versions of PyCharm - recent versions should be fine.

### Invalid YAML Issue

If YAML is copy+pasted from the course material,
it might not get pasted correctly in PyCharm and some extra indentation may occur.
Annoyingly, PyCharm will not flag this up as invalid YAML
and learners may get all sort of different issues and errors with these files -
e.g. 'actions must start with run or uses' with GitHub Actions workflows.

An example of incorrect extra indentation:

```
steps:
    - name: foo
      uses: bar
```

Instead of

```
steps:
  - name: foo
    uses: bar
```




