# Sorting by dependency

### Print jobs sorted by their defined dependency

Lets say we have a list of jobs and certain jobs must be printed before others, a job may have a dependency on another job. For example, `a` may depend on `b`, meaning the final sequence of jobs should place `b` before `a`. If a has no dependency, the position of `a` in the final sequence does not matter.

### Input structure and output

Input data will be in a specific format i.e. each line will have a job then **=>** dependency indicator and then another job. Here are few examples:

##### Just a job
```
a =>
```
result should be a sequence consisting of a single job, e.x. `["a"]`

##### Non dependent jobs
```
a =>
b =>
c =>
```
result should be a sequence containing all three jobs `a b c` in no significant order, e.x. `["a", "b", "c"]`

##### Jobs with dependencies
```
a =>
b => c
c => f
d => a
e => b
f =>
```
result should be a sequence that positions `f` before `c`, `c` before `b`, `b` before `e` and `a` before `d` containing all six jobs e.x. `["a", "f", "c", "b", "d", "e"]`

##### Job with self dependency
```
a =>
b =>
c => c
```
result should be an error stating that jobs can’t depend on themselves

##### Jobs with circular dependency
```
a =>
b => c
c => f
d => a
e =>
f => b
```
result should be an error stating that jobs can’t have circular dependencies


## Getting Started

This program requires **ruby** and **bundler** to be installed. Before you begin; install the dependencies by running:
```
bundle install
```

### How to run program

To start it the program write:
```
bin/jobs_list
```
Will attempt to run the application and print output to the terminal. We have a `inputs` directory at root level where there are some sample input files are added and used in the runner script. Feel free use new input files and use them in runner script i.e. `bin/jobs_list`



### How to run test cases

To run test cases write:

```
bundle exec rspec
```



