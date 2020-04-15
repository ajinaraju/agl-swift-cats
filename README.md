# Programming challenge

Welcome to the AGL programming challenge!

Please read the instructions completely and carefully. If anything is unclear,
feel free to reach out and ask questions.

You should *fork* this repository and make changes to your fork, which should
be *private*. When done, please invite `a144367` and `yilei-agl` to the fork.


**Task**

A JSON web service has been set up at the url:
https://agl-developer-test.azurewebsites.net/people.json


The iOS project you're looking at has been set up as a very basic app which
makes a request to the above service and downloads the data.

Your task is to write code to process the downloaded data and output:

- each gender as a heading (NOTE: there can be any number of genders, not just
  male and female)
- under each gender, a list of *cat* names, representing all cats owned by
  owners of the corresponding gender (i.e. all cats owned by male owners, all
  cats owned by female owners, etc.)
- for each gender, all cat names should be sorted in alphabetical order


Once you have parsed the data correctly, display it on screen in a table
resembling the below example. You are free to choose which UI elements to use.

**Example**:

 ┌──────────────────────────────┐
 ├──────────────────────────────┤
 │             Male             │
 ├──────────────────────────────┤
 │                              │
 │ Angel                        │
 │ ---------------------------  │
 │                              │
 │ Molly                        │
 │ ---------------------------  │
 │                              │
 │ Tigger                       │
 │ ---------------------------  │
 │                              │
 ├──────────────────────────────┤
 │            Female            │
 ├──────────────────────────────┤
 │                              │
 │ Gizmo                        │
 │ ---------------------------  │
 │                              │
 │ Jasper                       │
 │ ---------------------------  │
 │                              │
 │                              │
 └──────────────────────────────┘    

**Notes**:

    - The provided project may contain bugs, we expect you to fix them.
    - Assume there can be any number of genders.
    - Focus on the data processing part of code. Is it clean? How does it perform?
    - Use industry best practices.
    - Use the code to showcase your skill.
