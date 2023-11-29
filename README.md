# This Quick Action enables batch conversion of the JSX to JSXBIN files withn selected folder

## Description:

1. It will first copy selected folder with all it's content and add the ending `_encoded` in the folder name
2. Recursivelt encode all JSX files to JSXBIN files and remove the original JSX files withn `_encoded` folder
3. Display encoding progress via Apple Script at the top right corner
4. Any issues that may occur should be available in the `~/Desktop/JSXBIN_errors.log` file

## How to use:

1. Make sure that you have NVM, Node.js, VSCode and ExtendScript Debugger extension installed.
2. 


## Install NVM and Node.js v14.21.3

Follow these steps to install NVM (Node Version Manager) and Node.js v14.21.3.

## Install NVM

1. Open your terminal.
2. Run the following command to download and install NVM:
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```
This script clones the NVM repository to ~/.nvm and adds the source lines to your profile (~/.bash_profile, ~/.zshrc, ~/.profile, or ~/.bashrc).

3. Close your terminal and open it again.
4. Verify the installation of NVM by typing the following command:
```bash
nvm --version
```

**NOTE: if Terminal still says that nvm is not found, it's time to use another command:**

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
```

## Install Node.js v14.21.3

1. With NVM installed, you can install specific versions of Node.js.
2. Run the following command to install Node v14.21.3:
```bash
nvm install 14.21.3
```

4. After running the installation command, nvm will download and install Node.js v14.21.3. You may need to wait a few minutes for the installation to complete.
5. Verify the installation by checking the version of Node.js:
```bash
node --version
```
The output should be:
```bash
v14.21.3
```

## Set Default Node.js Version

To set the installed version as the default version for any new shell, use the alias 'default':

1. Run the following command:
```bash
nvm alias default 14.21.3
```

Now, the default Node.js version will be v14.21.3 whenever you open a new terminal.

## Switch Between Node.js Versions

NVM allows you to quickly switch between Node.js versions. To switch to a different version, you can use the nvm use command. For example, to switch to Node.js v12.18.3, you can use:

```bash
nvm use 12.18.3
```

To switch back to v14.21.3, you can use:

```bash
nvm use 14.21.3
```
