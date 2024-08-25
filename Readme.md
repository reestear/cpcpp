# CPCPP - Competitive Programming C/C++ Script

## Description

cpcpp - is an useful script which will enhance your productivity of solving Competitive Programming Problems by helping you to automate some common routines like building your code with some mostly used GCC flags, running your code on different tests without executing it many times, and providing nice visual colorings :3 <br/>

<span style="color:red; font-weight:bold;">Script only works for C/C++</span>

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)

## Installation

1. **Clone the repository:**

   ```bash
   % git clone https://github.com/reestear/cpcpp.git
   ```

2. **Navigate to the project directory**

    ```bash
    % cd ./cpcpp
    ```

3. **Copy script to your PATH directory**
    ```bash
    % sudo mv cpcpp.sh <PATH>/cpcpp
    ```
    Where PATH directory on UNIX systems is by default any of following:
    ```
    /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
    ```
4. **Activate Script**
    ```bash
    % sudo chmod +x <PATH>/cpcpp
    ```
5. **Look at the usage of script**
    ```bash
    % cpcpp
    ```

## Usage

1. **Navigate to the directory where your code is located and run:**

    ```bash
    % cpcpp <filename>
    ```

    In this way, the script will build the program with default GCC Optimization flags with *-std=c++20* and run the program immediately if compilation was succesful, otherwirse an error message will be displayed indicating an unsuccesful compilation.
    <br/>

    The same behavior can be generated using `-r` and `-b` flags, which will be discussed shortly later on:
    ```bash
    % cpcpp <filename> -b -r
    ```

2. **Run existing executable without rebuilding the same source file**
    ```bash
    % cpcpp <filename> -r
    ```
    If there exists an executable named `<filename>`, but without its `.cpp` or `.c` extension, then it will just run the existing program without compiling the source code.
    <br/>

    Otherwise, an error message will be displayed and program wouldn't be executed.
3. **There exists similar option but only for building**
    ```bash
    % cpcpp <filename> -b
    ```
    This way it will only compile the source code without executing the final output.
4. **If you want to run the same code on multiple tests (Not those tests which will be run in the program itself)**
    ```bash
    % cpcpp <filename> --tests=<X>
    ```
    Where, `X` stays for the number of tests which should be executed *i.e how many times the program will be executed*.

