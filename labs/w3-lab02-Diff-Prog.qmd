---
title: "Differentiable Programming"
date: "January 26, 2024"
categories: "Lab"
notebook-view: 
  - notebook: 02Examples/ad/diff_prog.ipynb
    title: "Intro Differentiable Programming"
  - notebook: 02Examples/ad/autograd_tut.ipynb
    title: "`Autograd` tutorial"
---

The notebooks can be downloaded from here

- [Intro Differentiable Programming - diff_prog.ipynb](https://www.dropbox.com/scl/fi/vpq005ixf4bd0td29iajt/diff_prog.ipynb?rlkey=xuvgsphmnfycf1eqvk8e42mee&dl=0)
- [`Autograd` tutorial - autograd_tut.ipynb](https://www.dropbox.com/scl/fi/z464xcgv5rvdfue6mfzv7/autograd_tut.ipynb?rlkey=09vq4nrnpdbl1yzsz50cr0lvw&dl=0) 

Please rerun both these labs. Take careful note of how to define a custom gradient. This will become relevant in the course when we compose learned layers with PDE solvers. The PDE solver gradients can be calculated with brute force with AD or as described in the custom gradient section you can define a custom routine to calculate the gradient i.e efficiently with the adjoint state method.