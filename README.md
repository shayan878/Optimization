# MATLAB CVX Optimization Examples

This repository contains MATLAB codes demonstrating how to model and solve **convex optimization problems** using the [CVX toolbox](http://cvxr.com/cvx/).  
The codes are inspired by the tutorial:  
👉 [YouTube: CVX Optimization in MATLAB](https://www.youtube.com/watch?v=XOcnVQ2HkEQ)

---

## 📘 Features
- Examples of **linear programming (LP)**, **quadratic programming (QP)**, and **convex optimization**  
- Usage of **CVX modeling language** inside MATLAB  
- Demonstrations of:
  - Defining optimization variables
  - Writing objective functions
  - Adding linear/convex constraints
  - Running `cvx_begin ... cvx_end` blocks
- Visualizations of solutions (where applicable)

---

## 🚀 Requirements
- MATLAB (R2019a or later recommended)  
- [CVX toolbox](http://cvxr.com/cvx/) installed and added to MATLAB path  

---

## ▶️ How to run
1. Download and install CVX:  
   ```matlab
   cvx_setup
Place all .m files in your MATLAB working directory.

Open and run the desired script, for example:

matlab
Copy code
run example*.m

📊 Example problems included
- Linear programming: minimize cost subject to linear constraints
- Quadratic programming: portfolio optimization with risk-return tradeoff
- General convex optimization: least-squares with regularization
- Constrained optimization: problems with inequality/equality constraints

📑 References
- CVX: MATLAB Software for Disciplined Convex Programming
- Boyd & Vandenberghe — Convex Optimization (2004)
- Related YouTube tutorial: CVX Optimization in MATLAB
